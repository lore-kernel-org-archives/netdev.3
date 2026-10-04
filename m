Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B826296
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077037; cv=none; b=XvCbj064EHTKQzXHgIjr0u6fWVknO7bS/8VnelcQryAEDxtEZYzjclX5B3N2K+DAgSukEkNd0ly6z4NtEo/BlqWkjjJYy+toaZk2mHx6z4jbJNA+/3CJhy9AwMZ7unGZIgqlcbi3X3hHnB29y2IAKlrbNUuEwuQll2W+k2X7jiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077037; c=relaxed/simple;
	bh=LX3eZ/DgHV51IkVCeksy1ap1xX5kMSDk+PX+61/jzpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQnWdfiGWWVKTi4KeFB4CdzBSNCVZlqCz6uPlN1hs5cN/9ziPyO0v4lruRtMyarNrxcjPaCZ2T/zGeb1OneTZbDW8Z7U2SW3Y9jy+562mUPNorKJWQnLzuEWu1LMDmiW0WMLmTPmhYZSpS3l4rqf886vTRDi+gChYHBC1rczytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVA/DeUS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVA/DeUS"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-351224e684dso367494eec.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791077035; x=1791681835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=32MCDfAvq4KE3yjH4nIAdZCu2QsOHyK08TzQ25bvmfo=;
        b=iVA/DeUS+bN7p0rvRe052q6nClnugqPY12lP7Ni/zlgX8+DrdbjRymaWqJwdx1yeVU
         PB9siCNGfMCqr3iH8g7lMHih06ZxUpQAvCM06hORiT+PVimCl+An2Smv5AFbGZJ6nmLS
         PWjPnwJ1KjDvun5cfTLYwLe6RTtsc2GyXkTT9FkqcCq/kkFh0u+jCk/fMQ2T9LnA4gnY
         yaXKRNIsJFdg7W+4ICvYzfG/ubvK2iVOjV34iCibQvfk5uVXaxPBcpJ/W7E0V6jPIoZ+
         RhJhERChZd2ZNRnUXV8J/GWeu/FrTWcweBK/EImxmrP1IVi0yjEyp+8JkaBEiZZs1Kk/
         y9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791077035; x=1791681835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=32MCDfAvq4KE3yjH4nIAdZCu2QsOHyK08TzQ25bvmfo=;
        b=Md/yUPSeez58eAy8bwzmA0os0VtFVFFUWau8Qj1g+PFPy+jIHBDYIyUOBrU4misxGo
         ano5u7PJx+qRBSx+wD08u2joCvVUSjbGGg0XPMVwnYhShJD2R59Qllzi122Yxvkvi7U1
         /biL0b7E6FqKsCPp+81Zdd+o+Y/H+W6VBlvHbJWQkhhcf7BrFab3jsUg+tLKgJYJFHyG
         NKIu+QUwwdoEr2kCLrap0rTkiaHzAyiOU1mixPejGKMjBnkDp7CsFsuAUREPvqr+OOfK
         Ye6EtJjhaL0YVOIulS91Epy7gt+naB/27BKUQ50iUEMjfDlxslQUOhactneo4r4bgGEr
         iZRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCXRWtb3RajZaAnWJ4JMEPCkHYhQSIbtJkZf8Qz0Ure70n/MO6xPGJwE7fGen2plVDfDmRMHU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK4Ha3bIx9MIvaqQXktSC1cb+McGZryDGlVuvjCrZw+R/aK3Bw
	KrJKKA9/jTrMVqObXTPzg9qrbLrLKwHyL0i1smM1phMpR6BouwD2+7hr
X-Gm-Gg: AYBFou3WIYDeTWNgirOoGBqw7g7Tsk2KOR8q4zOAxW7rcTbruepmoOAVNLOTcnYKjj/
	F+tyvg7yuSF//JibCN45yVTEIsXPyqoBUEYZ6SpFzMZYuiPra1fjREhfkEjnMpK+U8Oh0az4Oe/
	y4a8l9a1OWuLbZN1puZ4rYHmLYZIWOyXBoD3qDiqAEyB1xbLsZcyHHk7X0Spyx25sp/PcvyDeEa
	8M3oA7453VIiQZSH5CRDVzDQieKtBCTpnZJnWOMctin4iF4ySw6RBjGZTzxCyQqgU7yBAKi6ZFE
	tmOY6LFW9JjlL556E+eRXxsQW0u+N+NTVCMGJ2dQQZGVjZKXpGUQbV0KbxFUvptVhalb67P13Hn
	DimwvNPEpekjpAZ/0tKBA22SEisrb1TcKssdyy8ZKDbLxkDMYZWUwGnXglHW0is0axorPKojr3z
	feZMZvKuwtzPslTxXh5glSzI5lKJxDntxt/nvIv0DG958VHwSJzNbXpqQ/lD80zoABGpqzWeLOP
	OvnCg/I+owS2LIlBBshFg8BL2egmpte9lOl2J0VkiLbpGvONxGW6aRoEtZ+ew==
X-Received: by 2002:a05:693c:368e:b0:351:1230:e379 with SMTP id 5a478bee46e88-3511230e3e1mr4341684eec.6.1791077035328;
        Sat, 03 Oct 2026 18:23:55 -0700 (PDT)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272d5103sm506055eec.27.2026.10.03.18.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 18:23:54 -0700 (PDT)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jean-Paul Sergent <jpsergent@gmail.com>,
	netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: dst_metadata: fix fortify trap + overread in skb_metadata_dst_cmp
Date: Sat,  3 Oct 2026 18:23:54 -0700
Message-ID: <20261004012354.1805181-1-jpsergent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <787c2c1e-1260-43ae-bee0-9798e1e53c2b@ovn.org>
References: <20261003005449.2675.1@jpsergent.gmail.com> <20261003005449.2675.3@jpsergent.gmail.com> <787c2c1e-1260-43ae-bee0-9798e1e53c2b@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 03, 2026 at 03:31:07PM +0200, Ilya Maximets wrote:
> Here the function just compares two blocks and they must be already
> fully initialized and have options_len properly set.  If they have
> options, but the length is zero, that's a bug somewhere else.

Following up on my earlier reply: I captured the outer traffic on the
receiving node to answer where the differing options_len come from.
Neither packet is buggy or uninitialized - both lengths are legitimate
traffic on the same geneve device, and the comparison just cannot
handle the mix safely.

This cluster runs Cilium with bpf-lb-mode: dsr and
bpf-lb-dsr-dispatch: geneve. The service LB node forwards a client's
SYN inside geneve with a 12-byte DSR option appended (class 0x014b,
type 0x81, carrying the LB address and service port), while the rest
of the connection and all regular overlay traffic ride the same
tunnel with no options - this Cilium setup adds no identity option
to normal overlay packets.

60 seconds of capture (talosctl pcap, unfiltered; GRO is disabled on
the geneve device here as the standing mitigation, which does not
affect the outer side): 1,423 option-bearing packets from the LB
node, every one a TCP SYN, against 70,935 zero-option packets. 1,370
flows carried both classes on the same inner 5-tuple within that one
window - the SYN with the option, then data without it - all inbound
to one NodePort service.

How that turns into the overread: geneve RX pulls the tunnel headers
and clears the skb hash (iptunnel_pull_header() ->
skb_clear_hash_if_not_l4()), and these virtio netdevs provide no
receive hash, so every decapped packet enters the per-CPU gro cell
with skb->hash == 0 and dev_gro_receive() buckets them all into the
same gro_hash list. In gro_list_prepare() the remaining gates before
the metadata-dst comparison are the inner ethernet header compare and
the slow_gro path. DSR delivers every flow for a service to the same
backend pod, so those flows share the inner destination MAC, and
because the LB node encapsulates every client packet it forwards,
they share the inner source MAC - the LB node's - as well. With a
torrent client running on that pod, hundreds of concurrent
connections hit the same service: the SYN of one connection and
the data segment of another pass every check up to
skb_metadata_dst_cmp(), which then reads 96 + 12 bytes against a
96 + 0 allocation - the "108 byte read of buffer size 96" from the
original report, with the earlier packet on the GRO list (skb_a)
carrying the longer options, matching the reported trip direction.
GRO batches here live exactly one NAPI poll (gro_flush_timeout is
0), so a SYN and a same-service data segment merely have to be
processed by the same poll - routine at ~23 DSR SYNs/s mixed into
~70k packets/min of overlay traffic. This also explains why my
single-stream iperf attempts never reproduced it: a lone
connection's SYN and data are separated by RTT and cannot share a
poll, and it has no second same-MAC-pair flow to collide with.

The v3 patch restores the options_len equality check, so GRO
declines aggregation (clearing same_flow) instead of reading past
the shorter allocation; since the two packets belong to different
TCP flows, declining aggregation is also the correct protocol
behavior. I will post v3 once this discussion settles.

Happy to share the capture or the parsing script if that is useful.

-- 
Jean-Paul Sergent
