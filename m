Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754632AAB4
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743169; cv=none; b=ubD891BEOutAfpwiM/S1iv13zQquhBAupdyaCxtLBpBcFJtBeddOC2IUQGRanGjX6IWK5S/t+sNCtGUNQZMLZn4y7nJJh6RA9T6Z9WfX8jmQcQWWk6Dyp3q/lWD+se33mC0Dw/yXkaFgqN6Fzp3tSko0ohJ5VHbZxRG+udRNPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743169; c=relaxed/simple;
	bh=TeOq2WGx36/vhsxEB4LmTPs6NHH2522z9ZrglXR1Ev0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dcp26vjWxznPEZvr4Iqk5EyI5iv6WwUyBLzdhd/FqRigfiiWPAA9cjY6H2Qr9MgMpDyid/5UfRBbf16lJyPJpVkym2T3FPpk7NfyyGkybMo8d5XedczFJXU6PGnRVBsM0Wp+kraOHwk6nWsPTpJNbKqdFXI5EhqINH+lccbhvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=uRapuCaq; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="uRapuCaq"
Received: from ms-a2 (227.25.31.150.dy.iij4u.or.jp [150.31.25.227])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61AH63Pl051026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Feb 2026 02:06:03 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=YezTYZm45Fc+/sBHnpyG3y/+AmmZnnp675nXVb6MGag=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1770743164; v=1;
        b=uRapuCaqjzt2tSLkJafgkf45ZonwnV6PnUlsd0owq2EDy+33vnVuPpvt0BGl8hwa
         615kND/WPvWQi84vSX8vQO8lV5u52HLPfPOojUmj+EEXRb6eUlzkD6KgWhXerg1k
         eZxNSNDxZYZ7zkSmG2w1pj7/bx8i0dRMgnI37QDwiVpWM2twqUQ8DTWXvK7jFZqN
         MeaXZJ6HTl/exE2sTlfaphyqbJ7+VxQcR2hQHt8P4EpGeaB1Dx/cgRqhNoDMllEr
         MfqW3fH744oNl6zM9SF992V3lhT6z6alCGQq/WF8G8O/61j/r2otpovqP+0lgvHm
         3/phIwHRCaT5VzuerB9LdQ==
From: Kohei Enju <kohei@enjuk.jp>
To: aleksander.lobakin@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix netdev->max_mtu to respect actual
Date: Tue, 10 Feb 2026 17:05:55 +0000
Message-ID: <20260210170603.149842-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <c48f08ad-b402-4cfe-a362-4cb0c3a7801f@intel.com>
References: <c48f08ad-b402-4cfe-a362-4cb0c3a7801f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Feb 2026 17:37:23 +0100, Alexander Lobakin wrote:

> From: Kohei Enju <kohei@enjuk.jp>
> Date: Tue, 10 Feb 2026 15:57:14 +0000
> 
> > iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
> > from PF [1]. This allows setting an MTU beyond the actual hardware
> > limit, causing TX queue timeouts [2].
> > 
> > Set correct netdev->max_mtu using vf_res->max_mtu from the PF.
> > 
> > Note that currently PF drivers such as ice/i40e set the frame size in
> > vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
> > netdev->max_mtu.
> > 
> > [1]
> >  # ip -j -d link show $DEV | jq '.[0].max_mtu'
> >  16356
> > 
> > [2]
> >  iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
> >  iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
> >  iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
> >  iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
> >  ...
> > 
> > Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Although I'm not sure the 'Fixes:' tag is correct. Was vs_res->max_mtu
> accounted before switching to Page Pool? If so, then yes, my fault.
> Otherwise, this issue is older than libie.

You're right that vf_res->mtu was also not accounted before the commit.

The commit changes:
-       netdev->max_mtu = IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
+       netdev->max_mtu = LIBIE_MAX_MTU;
...
-#define IAVF_MAX_RXBUFFER   9728  /* largest size for single descriptor */

and thus netdev->max_mtu was already hardcoded, but just because
IAVF_MAX_RXBUFFER was valid for VFs there hadn't been any issues, and
invalid MTU could start to be set after the commit.

> I'm asking as IIRC before I did set max_mtu to the libie definition,
> there was a hardcoded value already.

Yea, as far as I checked the value was hardcoded from the beginning
(91c527a55664 ("ethernet/intel: use core min/max MTU checking")).

Although I'm not attached to the exact commit as the Fixes: tag, I chose
that since (coincidently) that commit made this regression.
