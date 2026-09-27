Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAED3A451D;
	Sun, 27 Sep 2026 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501098; cv=none; b=kAJXp49FhuUF0+0dfUa0FUA+KBS8le6izOjePjir4Zk4DW7+TT13j1l2C/7ilDdCG/f7pHeObYi1h58iG79lLnevcZe1Cj7J6z0WFrHlDjoAo8B5K9fTeqfobdVXfDeCeypQShTSILSW9msr+CSMeTuhMOE928THcih1DvEXhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501098; c=relaxed/simple;
	bh=pei+xcGmqAMvueMkf/in+B6kPjajVjK7Ko/S3JZifZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6WZmIepk7uK1hvyvbSRPf3twOnkPAiloqFITrOdpeVxpm37jc25e13QGOdcQRtY7ml+ErEaireLMHPb7TkIbatkyMfHsNrfdl+OJQdLlMTl7q2qi2jVUxY1vUhxUOF3mkKvvKld2oE1WDKC7abJVcZpKtibxnA6Ypm+7XYQ4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=P1yd2CaD; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=RV+UZEyY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="P1yd2CaD";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="RV+UZEyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501094;
	bh=pei+xcGmqAMvueMkf/in+B6kPjajVjK7Ko/S3JZifZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P1yd2CaDMdDuF8hEnEJeNqxI7CkXLyNPW7N2ab+YJtYKQ/Cbg9u0D81GdUw/FkAa3
	 jN7Fc89wfPGd4TPjtd8whjeXKuJB2GRNK985UAKK6A2+sMN3Qgaj7tA0uxZS1o7R/5
	 S/9FnlfL2/H5CN9mqRWnDu5gupXQKc429tsw0zrlIBIbmBjKhruSsEADqodp/pony9
	 vF2wAYtRoylRXG36Y+Fd48cIZqFhuXVc0777V3XVshkejhjutH4VgvHAT0MV0s0Wk2
	 qjgYbsAGUsBvC6u4u5reSZ9fxJgWUsRleo04PQ9BjP1zKiXn2eoXSQrgSesoXgmxaB
	 4gIVFDlG2q8uA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E295041308; Sun, 27 Sep 2026 09:24:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501092;
	bh=pei+xcGmqAMvueMkf/in+B6kPjajVjK7Ko/S3JZifZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RV+UZEyYhPTCs1j0wvcLXnxcWnXPkNiBkTw4eC2L5pRRAmllpWbRoZYZfBQIVVY8V
	 loLq633KGIGzoLAuXO6E+t5Wgdo3CwR/shpKtiHlKU2ftvQp/XVVyVqExtLHBJSWjn
	 48MIezuKUD54GV3a8fvjuZv9mbBM4fvTk5jQfbwKMhZOcZ/qReUQNvNG0VXLieOGbp
	 Mdz0PMdQ0WZhYO63ABYlHWe9uuqlBFgJHVeZGQkyCtJzEaG5j0B2FKK5RcadDgICQu
	 +DJstTVgsdAYRbbE4WFLSKVZYQrxcC9+T9r/LVGxXY2YcvKzxCFOxFGnCFX6jnxrkm
	 oe9vGWFrLJaMg==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5BC05412E0;
	Sun, 27 Sep 2026 09:24:52 +0000 (UTC)
Message-ID: <289700c4-8569-4160-97c5-2fc37a901a9d@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:24:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/15] ax88179_178a: Add VLAN offload support
 for AX88179A
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-9-60c04c9924a2@birger-koblitz.de>
 <178968030096.22033.824447734953057557@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030096.22033.824447734953057557@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 4 · Medium: 5 · Low: 0
> 
> - [High] ax88179a_set_features()
>    (drivers/net/usb/ax88179a_devices.c:578-603) clobbers the persistent…
Will fix by moving conditionally setting AX_VLAN_CONTROL_VFE after the
loop over the VLAN-entries.

> - [High] This patch newly installs `.ndo_set_features =
>    ax88179a_set_features` on the AX88179A ops table…
Moved the rx_checksum tracing addition into the patch that adds the
AX88179A HW support. Made setting the checksumming feature on the device
dependent on NETIF_F_RXCSUM flag setting in ax88179a_reset().

> - [High] net: missing endianness conversion for subsequent Rx descriptors
>    in ax88179a_rx_fixup
Will add u64 pkt_desc = le64_to_cpu(*pkt_desc_ptr) within the loop
to account for endianness.

> - [High] net: unswapped read of rx_hdr yields garbage on big-endian
>    architectures
Duplicate of bug fixed in commit adding ax88179a_rx_fixup()

> - [Medium] The series is not bisectable: the VLAN feature bits are
>    advertised three commits earlier than the callbacks this patch adds,…
Will fix by moving the VLAN feature bits into the later patch that
also adds the netdev_ops.

> - [Medium] The new VLAN register sequences ignore every USB register-
>    access error and still report success.
Will fix by checking return codes in ax88179a_vlan_rx_add_vid(),
ax88179a_vlan_rx_kill_vid() and ax88179a_set_features

> - [Medium] All three new functions read AX88179A_VLAN_ID_CONTROL into an
>    uninitialised local u8 and ignore the result, then transmit a value…
Fixed by above checking of return values.

> - [Medium] The new `data->rx_checksum` write in ax88179_set_features()
>    (drivers/net/usb/ax88179_lib.c:369) races with, and is ordered wrongly…
  will clear rx_checksum before disabling the engine and only set the
   flag after the engine has been enabled.


> - [Medium] Enabling NETIF_F_HW_VLAN_CTAG_FILTER makes
>    ax88179a_set_features() (drivers/net/usb/ax88179a_devices.c:582-596)…
> 

You ask: On a busy bus, or when a transfer stalls and hits the timeout, 
this blocks
   all other network configuration in the system for a long time.  Could the
   clear be limited to rows actually in use, batched, or moved out of 
the RTNL
   section?

It is not possible to limit this to rows actually in use, because this is
clearing the rows _before_ use. These rows appear to contain garbage
on reset. Moving them out of RTNL scope would mean moving the clearing
elsewhere, but this also does not appear to solve the RTNL issue:
the logical place would be ax88179a_reset(), which however also runs 
under RTNL.
I do not see how batching could be done. Since the same issue is also
in aqc111, and this is not critical, I would like to push for a later
solution of the issue.
