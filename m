Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227EB264614;
	Sat,  1 Aug 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785560890; cv=none; b=MMrE/nxkRrdIQKpJYErqsoNounCJLSrh7GQSQ6OmdSc1RauKRZKu5d+COkklU691DDoOv+1q2l6L5J460Xxru/irbgV7CGuiV3KR4FLb30yf8VU+fbRAP6QqBXaM8Uh/JLvALWVO7kRBpsGYKqFBl3iseh2fCtTBebMIrEhzbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785560890; c=relaxed/simple;
	bh=VelhFpD4RVQabrdFZ3iaKWf2D6FBP8PtsqsQCckFvvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNFfacvdlXwOIDRLismvDMsBS79PTktSuf1b9hnWC5pbLfrya+nXOkDzxsoeuhbszqhNNaOBIyk3OJhMX/nkymcMLqpozCxd3VqgfpnJFDvAylGB8/AYfnTgqMdcxS1I8JLfvIjdaiPpV4rM4IPF+qknWk95FkLpPiwOwGr20Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wq1wo-00000000382-2IYD;
	Sat, 01 Aug 2026 05:07:46 +0000
Date: Sat, 1 Aug 2026 06:07:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/5] net: dsa: wire flash_update devlink
 callback to drivers
Message-ID: <am1_H0cwO1ehMsU2@makrotopia.org>
References: <cover.1784945329.git.daniel@makrotopia.org>
 <f1a39d3d955be3da51b333959ecfe626b8d6dfc6.1784945329.git.daniel@makrotopia.org>
 <a35bf784-a5c5-4a6b-be43-4d7a2e0dc663@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35bf784-a5c5-4a6b-be43-4d7a2e0dc663@lunn.ch>

On Thu, Jul 30, 2026 at 11:08:35PM +0200, Andrew Lunn wrote:

A quick note first: this review crossed mid-air with newer versions,
v6 through v8 were already out. v8 is the current one, where this
patch is retitled "net: dsa: add devlink flash_update callback to
dsa_switch_ops":
https://lore.kernel.org/all/2103d1c460b35c5e59c96bd91a892596478474d1.1785389905.git.daniel@makrotopia.org/
This part is unchanged there, though, so your comment applies as-is.

>> +#define DSA_DEVLINK_OPS							\
[...]
>> +static const struct devlink_ops dsa_devlink_ops = {
>> +	DSA_DEVLINK_OPS
>> +};
>
> Is this going to scale? How many different permutations are there?

It obviously doesn't scale. The choice to do this was because the
cost of requesting an update file, which would happen before the
-EOPNOTSUPP, is a relatively high cost. None of the other devlink
operations have such costly side-effects even if not implemented by
a DSA driver.

> Firmware upgrade is an infrequent operation, so do we actually care
> about a request_firmware() which might turn out to be pointless? I
> personally would prefer to avoid the scalability issue and just return
> -EOPNOTSUPP.

I will drop the macro and the second struct, make .flash_update a
regular member of the single dsa_devlink_ops, and have the trampoline
return -EOPNOTSUPP when ds->ops->devlink_flash_update is absent in v9.


Cheers


Daniel
