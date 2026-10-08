Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE8225788
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422656; cv=none; b=jpRua0RTYP+VYkby66rF4JVene94dy+0oflaM5DBCERl8lU2nH7+rjG+BX9oiFrq/bLFSo4UFANh6ASCstMysljBicTuUu+8KONYde9Cu5KdMAdEI9QsMgqEkqwIQrHcneYUALyhjRxUGIwygqwD1r5sHMQcvxmkX12mORci2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422656; c=relaxed/simple;
	bh=QHrFURBA+G/0G8SIdBTX/sc3YxucPrQ6ndmK7X1/yco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaSFvbuaiRvA1Px43r+f0UOGms0zr3WFA0xK2dm100w3XRYvkvOSaSGfjwZJhtH40lKopEXgN0IkoShSUKpek+QNtL36sqisjQjBz1+4ZJmAKB3/bnq6jw88vgFN4L9Rls0g6qi35K26WVDhXwEDaCruLE32q1ro53FMElZxRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVnmVvZk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVnmVvZk"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso4198618e87.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 18:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791422653; x=1792027453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZ3DcSTW+nO77dITj3/YKe4zOzGdIE2NRXQbJlHL3qw=;
        b=QVnmVvZkL+pz4t8N4GsPg3iiZwRYhk/CX+/rrBERcYhn2fBRl1tL6Rp9Y96/Rn8cZ6
         aSZrsohXbpC8WSCpMxNXQCKCESrIZpFu3mev/8Uezb12Hx9/0NAlGWBjWpsD60Jkql4V
         M/pJmndQkuIzQX+kH9exkZas45t9YgDHcuDUBkZ4cZkHkTeWE/Iu4iEV8lY/W2rO96d0
         wyVvu6QODM6F13R217aC/NjzVN+LWbq9FDzvNZeJFO25bn19WIaKut59qsaWyhGiK0U9
         nkXD+pwjEH/zpoGjN5RafW/O391jAaM8kT0VANuODjluAYyZ2vd73PvlKDQvbrKmKiL9
         zKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791422653; x=1792027453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZ3DcSTW+nO77dITj3/YKe4zOzGdIE2NRXQbJlHL3qw=;
        b=h/UQi6AzIQvcpx73m7P9P+22dGwEcDFQLbSrQbHT46F6baTefdg6NBqN+ifBBciuvK
         CWtCnkv3lW+/Uq2iAu2TVG7iEqV3gxhYaVwP9CTyHS95aLaLrHW4PPwiyVweLg2I6Eks
         KyrSm/gxqLehwiMrYS6NGD9q5yvSIceAqg+rfTl2QoV/MWFukGkUgoq0l+XuRVdkCIWw
         oGt4jgarUpH93XT+FEo3DKCc0RsvNDIhp0Y6OvE2VAE9RnHUp9LWWEF+hX9z9PhMhPKU
         GsfeD/AmHIa4GaYW7wWLICwaIKJp0dMg5CyFHMvEO+/82NsubUoVs279iF275W+1R96G
         kKeg==
X-Gm-Message-State: AFq9FYJswYfnjtJXmj8vaHoczzFxtoFTyRsRUKs7VQIgK8YOjBigr5CS
	p/fA81kl2lwnsd8przhMTRN5meUVcLphZZGssdAF4j/Vr96p9ueyesvtvknMr33WFhQa7g==
X-Gm-Gg: AYBFou3qDcOgW7XuDgvm6fYH66NYy4m1xCwsQMnHW53kgXSQRnWTdTaFoLEDQe6rcum
	vncXReCGukDbOCnERjO/Nb9FwSfwXftCP+n8TNtSlbti6tPZVbNvhhBMJmFCLTt53kaWSJnZU90
	jmQjMeWbfWcLeef0kZz1EAlfcGqW4zv0rCesbcF/byVvZIrneChRnaMkv0iXdNJPIZHfnuYiOar
	crC8cQFNDxFYvTzYbrdemy8FT+1JosYuwsCLTEs3CTF6Y9xjvXKNMdFB1e7vwkHmZQbItUPVPAD
	2xkSxx5QV5pVZVdaq8sYauSvk97cOFWE/5QLxTUj8wbpsIAxSkuK9dLL/TH9q/bL7UreROLD9Ji
	i6MNvOtd3vMvFYEpLhjkmNrAoL4swnWPGiunwLMqmyR+g9Dz69IDFnOs5eiv5W9lk9f8yqTP/1R
	p5yaOEc2eV+rVAWgiMCg3l13Asee55v1lFr4g/JS9gaRyM4TtGWoX4h5qiS/od7Egs4EHpiLoUT
	qW0EUc4eVfytzpJie7OtXkBJ2lRkyRTqNm/sEfHZTf1
X-Received: by 2002:a05:6512:428a:b0:5bc:d39d:aa20 with SMTP id 2adb3069b0e04-5bcd39daa59mr351682e87.10.1791422652918;
        Wed, 07 Oct 2026 18:24:12 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.183.164])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd3016019sm605990e87.1.2026.10.07.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 18:24:12 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Mazin Al Haddad <mazin@getstate.dev>,
	Matthias May <matthias.may@westermo.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Thu,  8 Oct 2026 04:24:08 +0300
Message-ID: <20261008012409.202607-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179141499719.434549.15788178109134377075@kernel.org>
References: <20261005231414.932997-1-littlesmilingcloud@gmail.com> <179141499719.434549.15788178109134377075@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 07, 2026 at 11:16:37PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.

Thanks. All three reads are real, and all three are the same without
this patch; numbers below. The frames are written to the device through
an AF_PACKET socket, on net (9b6c20f78847) and on net with this patch;
the receiving end runs KMSAN and reads the packets with a packet socket.
"reports" is the number of KMSAN reports there (kernel-infoleak in the
packet socket, or uninit-value in the ICMPv6 error that quotes the
packet).

[...]
>> +	if (dev->type != ARPHRD_ETHER && dev->header_ops) {
[...]
> [Severity: High]
> The commit message says "This fixes the check and the skb_protocol()
> dispatch in ip6gre_tunnel_xmit()". Can this branch still read an inner
> header that was never pulled?
[...]
> The commit message lists this branch as a follow-up. Should the "This
> fixes the check and the skb_protocol() dispatch" sentence be narrowed
> to say this case is not covered yet?

Yes. That branch keeps pskb_inet_may_pull() byte for byte as net has
it, and it is reachable only on an ip6gre device created without a
remote and later given one with changelink. v6 narrows the sentence to
ip6gretap and ip6gre devices created with a remote; the branch stays
listed as a follow-up.

>> +		if (skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER))
[...]
> [Severity: High]
> This is a pre-existing issue, and the commit message lists
> ip6_tnl_xmit() as a follow-up. Even so, can a short tagged frame whose
> real inner type is not IP still cause an uninitialized read after this
> check?
[...]
> That reads 7 or 8 bytes past the skb tail. Can that uninitialized byte
> go out on the wire as the outer hop limit?

It can, on net and with this patch alike. The 18 byte tagged ARP frame
from the review, with 0x0800 at bytes 8-9 (ip6gretap with a key) or at
bytes 0-1 (ip6erspan v1), both devices with hoplimit inherit:

                                     net             + patch
  ip6gretap, bytes 8-9 = 0x0800      hop limit 0     hop limit 0 or 173
                                     15 reports      15 reports
  ip6gretap, bytes 8-9 = 0x86DD      0, 15           0, 15
  ip6gretap, control (no 0x0800)     64, 0           64, 0
  ip6erspan, bytes 0-1 = 0x0800      0, 17           0, 17
  ip6erspan, control                 64, 15          64, 15

The hop limit is whatever lies past the end of the frame: 0 in three
runs, 173 in one, with KMSAN reporting it as uninitialized on net and
with the patch alike. The 15 reports on the ip6erspan control frame
are the TOS that erspan_build_header() reads past the end, see below.
With the follow-up that makes ip6_tnl_xmit() walk the tags from the
inner MAC header (it depends on this patch and will follow it) all
rows give hop limit 64 and 0 reports.

> The commit message describes this case as inheritance that "is still
> taken from the wrong offset". Would it be more accurate to say it can
> also read past the end of the packet?

Yes; v6 says so.

>> +	skb->mac_len = 0;
>> +	if (skb_vlan_inet_prepare(skb, false))
[...]
> [Severity: High]
> Does this check still let short frames reach erspan_build_header() and
> erspan_build_header_v2()?
[...]
> Can this put uninitialized tailroom into ershdr->cos, and into the
> ERSPAN VLAN field when the in-frame ethertype is 0x8100?

It does, on net as well. The check here is for the inner IP header,
which is what the skb_protocol() dispatch reads; the TOS and TCI reads
in erspan_build_header{,_v2}() have had no length check of their own
since 84e54fe0a5ea, and this patch only moves the minimum from 10 to
14 bytes:

  ip6erspan v1                        net          + patch
  14B frame, EtherType 0x8100         18 reports   18 reports
  14B non-IP frame                    15           15
  18B tagged non-IP frame             15           15
  10B frame via tun + mirred          3            dropped

The 14 byte frame with 0x8100 is reported as "Bytes 62-63 of 84 are
uninitialized": the ver/vlan word of the ERSPAN header. That is a
separate fix with its own Fixes tags: two patches, queued after this
one, that read the TCI with skb_header_pointer() and take the COS from
the frame's own protocol; with them the rows above give 0 reports.

> The commit message says the short ip6erspan frame is now dropped. This
> looks like the same over-read, just a few bytes higher.

Agreed. v6 lists erspan_build_header() as a follow-up instead of
leaving "the short ip6erspan frame is now dropped" to suggest that all
short frames are.

v6 changes the commit message only; the code is identical to v4 and v5.

pw-bot: cr

---

Anton Danilov
