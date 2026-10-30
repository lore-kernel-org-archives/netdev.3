Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329639;
	b=osfrmEN2wwpfD6ys7ghoi1AV/emB440iPZK05U+dqY2T4AzK8jr6l7fKNb7bJcUTr12v
	 NsLPJqtQW/tArWRVbnYYQOBlHWRKnj/ODwe7SdAbnksBwDuZPBxvGvvufF2zESM5Hpqbk
	 mefcvQji7TcM0ux/rxSHPWFDuIg55Szot/34GrMzcuFjMEllB98q5shpNMWFyjvUCaVac
	 Qgm5TOO7x5vCDsZME/SWzGETMvdLbC139mi+7/+E4yGi9KFkkf7O7TGE/2pTqAEvTfEdP
	 Sy6MekbQvq5CoRoD+BhzAg7avO80kPqreKQplPz9rFX8H8jM7wWsQfZqZ2zJ8MVfYyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZM/x67kZFWzNFHq6c2CFofQ7P7hekwtvQXb7jH6aHSw=;
	b=LxR4wxMq3U06fz2iKuVqXFnGVIvZrwJXU2rEzQBqkgUzCBAUbtzTK6b7YYdsN6AKhir2
	 ICUciKGc5tBv9diZFIOuJS2xQ31XVzepnhNiMJEg6peNbXJFZZJMYG+AG0eWpnv81OXV1
	 eJwb5gR7u8TWbwNjRuRIHlfAVgeWOE2faWLuo+WjUpulIiZoMwPa/dCjVS4ITxkU9A3bO
	 padxcKRQHPFtOnZTn+Z6VP2VoQOaH+lsKrf67sf0N9cxihRWBu1hyw+bLC/eAjU01BEPK
	 oKSHZPBGYzEv2qrq7KpNCwvHbrMapU2+kMp9wvlelkFEGxki0MDomITe6Nf+O/ihfiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--starchang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kB1VQOe3;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E87606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E87606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--starchang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kB1VQOe3
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a26fe9521so1359149eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793329638; x=1793934438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZM/x67kZFWzNFHq6c2CFofQ7P7hekwtvQXb7jH6aHSw=;
        b=kB1VQOe3PZag9TaZd3CP49bRPJwMssqL7qcUGvBJoq78curtxR8+5TZNMSw5QIqDUm
         E/eG0EIJcUhTzpIrm+YkQ/D0OQF2pw0GAYB6BFLcf+2F9NqprbCiDxOqP3A0zqod/wBJ
         /tvmjITuhldJk6JYVv4FUgAK6iu7ne/MCC+vUFekpILFlRzuSQdcyq9bkUpMmy5TYLW6
         OHTEB6epLtjHJmWOy0u30NtfMvg/EeofNLqsTo5sxV5pV8V6hJGcZb/XZ4XMDuL0+pab
         6CSS22U/0x4Qq8yHHFwuAEJtQHNOCSymdn9pKbxzN2Ouxd3EJbzmeias4eEV7DPLx9qy
         UCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329638; x=1793934438;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZM/x67kZFWzNFHq6c2CFofQ7P7hekwtvQXb7jH6aHSw=;
        b=fBWYnrLIJkgHrUkH08NvCBIx9uRQl3eXJRYCxxbPZPdN/KwEw4SAVRueXWbIuVlsJz
         O/XVyy+ZisadPe8OEl+0S/q3lF+vJ9EbmtopDWYUCDKdRMkZYVkR8y9Le+udRbRu1HBs
         1KqceZ4yrbYHqaGyIl+xEeX8p8WJL9fBreOL45p0fwENS/N91S6dvmYtN+kLXWmKdTe9
         Y9aUahlnz48XIoRBYE15sn4UEHchj7ySDJd5oqlyWPirK/7ur0sFxBWo+nuia2zSjHWa
         n53yRdACBncjYr6GbSdWQG76NJyvClIVWBxxxnZOyCfqqqagEcL11SnAeZ8H6A7FW0U2
         eKFg==
X-Gm-Message-State: AFq9FYL8OQG/+DWXLjwMsPnnWvfZWIIXIEUWVUsO8xS1NV23PDUiHrf9
	/NJVAkENxx0pLNs8k/Rl0wuAgN7sHQAGxY4bNyWaFNELtXD3JHOY/bzOIq/6ma4S8aaznkF+Hi1
	ZcqjhbxiC1R/c0lzUXg==
X-Received: from dlx12.prod.google.com ([2002:a05:7022:8c:b0:19b:2ad6:6374])
 (user=starchang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:3c02:b0:196:b805:9546 with SMTP id a92af1059eb24-1ac5a67f996mr1102998c88.10.1793329637789;
 Thu, 29 Oct 2026 20:07:17 -0700 (PDT)
Date: Fri, 30 Oct 2026 03:07:15 +0000
In-Reply-To: <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026150539.1357037-1-starchang@google.com>
 <20261027015619.1745984-1-starchang@google.com> <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
 <20261028061644.2997812-1-starchang@google.com> <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030030715.604215-1-starchang@google.com>
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: Star Chang <starchang@google.com>
To: ja@ssi.bg
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, johannes@sipsolutions.net, johannes.berg@intel.com, 
	linux-kernel@vger.kernel.org, wangroger@google.com, starchang@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Julian, Sashiko, and netdev reviewers,

Thank you for the detailed review and feedback.

The points raised regarding the IP part are completely legitimate:
1. The pskb_may_pull() failure path did indeed introduce a potential UAF re=
ad of &iph->daddr when skb->head was reallocated.
2. Furthermore, exempting UDP port 68 weakens the Hole-196 protection. In p=
ractice, DHCP clients operate via AF_PACKET raw sockets (which tap frames b=
efore IP input) or rely on broadcast destination 255.255.255.255 (which rou=
tes as RTN_BROADCAST and is never dropped by drop_unicast_in_l2_multicast).
3. The net_warn_ratelimited() calls also introduce potential log suppressio=
n risks under a packet flood.

Therefore, we have completely dropped the IP and IPv6 changes (ip_input.c a=
nd ip6_input.c), preserving the original silent discard behavior per RFC 11=
22 and removing the extraneous IPv6 Fixes tag.

On the ARP side:
We have simplified the logic per the discussion with Julian:
- Strictly drop ARP Replies in L2 BMC unless they are Gratuitous ARP (sip =
=3D=3D tip), recording SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST via kfree_sk=
b_reason().
- Leave ARP Requests completely untouched per RFC 826 (eliminating any chec=
ks on tha).
- Legitimate GARP (sip =3D=3D tip) defers to the existing drop_gratuitous_a=
rp sysctl.
- Updated Documentation/networking/ip-sysctl.rst accordingly.

We will submit these changes cleanly in v5.

pw-bot: cr
