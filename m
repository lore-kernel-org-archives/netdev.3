Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE626B971;
	Sat,  1 Aug 2026 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561090; cv=none; b=VO595qXyfJJxLpJHbn45EawgaIMI8UsSVo/PzyO+FjyaS+/09lWasJpZw6s9+Wnu1R/9makYc3m9/czZZcnI5KZ1jqpfFXJ3aXOvaaJhWGOX02ET0nFfrpA0mYzcgXFT0Hu+jOXcdm2e0GtpL0F+UhFROzr5XC4KXbnm8qzyxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561090; c=relaxed/simple;
	bh=uzvfhUZICnZgPX0FvxYlIezlfYx2k1ZfbeO9G5r8I18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsrWIEh52PBnkCH1fp1K5UyQpUoL8rE2tEVgbj3E0KGyTGIYk1I1pk16QTmkqFdRx6H4T8SXZQtHbStNYyiBV4/MtxKrpkiMVdPa/IydxwJkClIbUHflaJPFFp7/O/etPWrOulrSM03eYG0VWTngycgX8hMVms0c6Jhka7Cw5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wq20J-0000000039d-0kn4;
	Sat, 01 Aug 2026 05:11:23 +0000
Date: Sat, 1 Aug 2026 06:11:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <am1_-Hb-W25G1o0q@makrotopia.org>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <73a63f1d11658a041514f79ae177bfb93153d33a.1784945329.git.daniel@makrotopia.org>
 <14be7694-8ec7-40b9-8845-d93896ed822c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14be7694-8ec7-40b9-8845-d93896ed822c@lunn.ch>

On Thu, Jul 30, 2026 at 11:29:47PM +0200, Andrew Lunn wrote:
>> The switch leaves MCUboot on its own by booting the new image, but the
>> driver has no in-place path back, so it reinitialises with a full
>> device_reprobe() scheduled regardless of the transfer outcome -- after a
>> failure the switch is still in MCUboot and probe re-detects it. During
[...]
>
> Just for my understanding....
>
> The reprobe causes all the user point netdevs to be destroyed, and are
> then recreated?
>
> That seems like a good solution to the issue of all state information
> has been lost in the switch.

Yes, exactly. device_reprobe() runs remove(), which unregisters the
switch and with it all user netdevs, and the fresh probe registers
them anew. They come back administratively down and userspace brings
them up again. Everything is rebuilt from scratch rather than
restored, which is the point given the switch itself lost all state
too.

>> +static int mxl862xx_sb_pdi_poll_stat(struct mxl862xx_priv *priv, u16 expected,
[...]
>> +		usleep_range(10000, 11000);
>> +	} while (time_before(jiffies, timeout));
>> +
>> +	return -ETIMEDOUT;
>
> I suggest using iopoll.h. This code has the usual bug when rolling
> your own.

Agreed. Since v6 all SB PDI polling uses read_poll_timeout(), which
also does the one more read after the deadline that the open-coded
loop missed.

>> +/* Post-flash reprobe. Runs from a self-contained heap work (not a kthread and
>> + * not the devlink caller's context): kthread_create() in the caller context
>> + * fails -EINTR if the devlink command was Ctrl-C'd, and schedule_work() cannot.
>
> A English sentence should not finish with the word "cannot".

That comment, and the kthread it talked about, are gone since v7; the
reprobe is a plain delayed work item now.

>> +	/* Failures from here on must go through end_magic so MCUboot
>> +	 * reboots instead of waiting forever.
>> +	 */
>> +	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
>> +					MXL862XX_FW_READY_TIMEOUT_MS);
>> +	if (ret) {
[...]
>> +		return ret;
>
> What about the comment above? end_magic?

You are right, in v5 the comment and the code disagreed. It has moved
on since: it turned out that END written while the loader still sits
in its receive loop is consumed as a byte count and can underflow the
receive counter, so since v7 failures deliberately do not send END
(the loader finalises on its own 2s timeout), and v8 renamed the
label to no_end with a comment that now matches the code.
