Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731123;
	b=UDCw9+xVWZpZs2ZEc+WvVDZmdaw5mQ80eV8gLZHcFRwGP7FVLQs2rY2kHLU2sXWiyn8b
	 LOIz/ALd7Jij/rPT56epDgIZ84rxO66WsOFL00RwLXxGTOMcX/ZiW/l2rkqr+odx9u97u
	 uwwLQp2fr0Oz7xraTMuCoLjmfn+AhABTmHaELZtD1yQ4PF5CVYlBAIJetSReQhpB93ruE
	 pMmvj9fiPjjcRorXDlHoHJLHqBdrZPWyy2spfn6MG8Ec4yIwF9Pz1f9KDvxUANvGLNrtV
	 beEhL7WSadF+aIUzTk+tNCE9TtHF8ppBpusPHkyk+Loi37akFbXhD8ot4E0WqKoZg0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731123;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BoB/A1sIi/INkgoVC9AAFNKr7YKhQUbQ+JtYOmccKaE=;
	b=AnA8aD5zMAHDJTxdTuDwAkrr26lUOM6vZ4sG3hbSI7Ll31HIagBIZmolJzCKE8Zp4VRl
	 tW4qxRGfvI7y82Iv44RR6bQl+Xs9Ya6+nx6pwbBOmQERfLvuV4tH5UPWE4XdTtE7nD7Wc
	 sLkpN/xd9VW/kRWeRYB7WKZ9oVUtor83KMgoxtXirKkwDRzHanBqZLoySsHSh+7QNnutO
	 gFDJ/UPZ470bVV6oGueh1I3DaW/6imcfTDU7tV8RekVjJnz2jnblEWi6YwVsmS/MQ9pOu
	 MDC1cbMDwNF1ZGP6PdKBSAp50jPEpq2oS9y57Om20qV2GAUryFb+Zds3m4HkRGv0Jbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha4V+Px4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA1606A324
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha4V+Px4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92E71F01825;
	Fri, 23 Oct 2026 04:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792731122;
	bh=BoB/A1sIi/INkgoVC9AAFNKr7YKhQUbQ+JtYOmccKaE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ha4V+Px40uunuItMDirEmvN1G4w/6nhYdHlSNLpf8paKd/rUtTd+wHcsWbIWeh3GD
	 LKrDwytd64GaIIfsmbD/j/9gf7BHplAqBgp3l/kTDVED007liwV2WGOermBWF5qfcO
	 tLGgQLX1Y6A8QeXHVR2/tSCuONL96UW/Bjn/xiiVoz4Y4Kd/gnKCPhA0T96Io5fZu5
	 KqK5I2Zbhb6R/KGZKRp/We9eIpPMEBdMj1glD5VbZUY7eRcxsXRAOmp8cPanCmDJsJ
	 SErKFtysFh+XDSmW/y5rDCe2OyDG+E5MBzBUz2TRTWAg+64uso+iw/+/rBv+IQDT7j
	 N/2qfuwKE/wyg==
Subject: Re: [PATCH net-next 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, jgross@suse.com,
 sstabellini@kernel.org, willemdebruijn.kernel@gmail.com, fmancera@suse.de,
 almasrymina@google.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 23 Oct 2026 04:52:01 +0000
Message-ID: <179273112116.3134.13075947496257634766@kernel.org>
In-Reply-To:
 <20261019-b4-skbuff-bug-on-followups-v1-4-41dbef50b9f7@toxicpanda.com>
References:
 <20261019-b4-skbuff-bug-on-followups-v1-4-41dbef50b9f7@toxicpanda.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a real, user-visible TX bug but has no Fixes:
  tag (and no Cc: stable).

--

net: skbuff: fail segmentation when a segment can't be checksummed

This patch changes the sg && !csum software checksum path in
skb_segment() to use skb_checksum_full(). The segmentation now fails with
-EFAULT when a segment can't be checksummed. This covers devmem TCP skbs
whose payload is in unreadable frags: skb_checksum() used to warn and
return 0, so the TCP checksum didn't cover the payload.

Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/

> Found by the Sashiko AI review of an earlier fix for the same path with
> SG off.
>
> Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

[Severity: Low]
Should this have a Fixes: tag, and possibly Cc: stable?

Before this patch, the perform_csum_check branch of skb_segment() called
skb_checksum() on segments that share the devmem skb's net_iov frags.
zerocopy_fill_skb_from_devmem() in net/core/datagram.c never sets
SKBFL_SHARED_FRAG, so the __skb_linearize() fallback is skipped and
__skb_checksum() ends up here:

    if (WARN_ON_ONCE(!skb_frags_readable(skb)))
        return 0;

That WARN is fatal with panic_on_warn. tcp_gso_segment() then writes a
TCP checksum that doesn't cover the payload that goes out.

This path became reachable when unreadable-frag TX skbs were added by:

bd61848900bf ("net: devmem: Implement TX path")

That looks like the right Fixes: target. Another patch in this series,
"net: skbuff: fail checksum validation when the skb can't be checksummed",
does carry a Fixes: tag. Without one here, the stable tooling won't pick
up this fix.

This patch also calls skb_checksum_full(), which is added by the earlier
patch in this series, "net: skbuff: add skb_checksum_full() that reports
failure". Could the commit message mention that dependency, so a backport
takes both patches?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7%40toxicpanda.com
