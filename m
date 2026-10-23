Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738148;
	b=K0OYZcKC0kS8PRcHR1+9G6SwicKxYiPgo8DQMvR75+BmAunTvux0E+MxQs8iVz6t37Dm
	 D2pbyKFDn8DmBclAHZJR5asaPUifSqY8Hdam45du+5x9xhyqau/NV01FZ+BAYOd1XvzqG
	 XX0msBC2OuvqG5i9GiekidI3AjqEjtCQZtC0eCOzIRno3uglt1u+vhZlmy1UkMo7dKn0o
	 D/AW8nUQcBU38am1RgOnYHU3g2ygjYYxdsMLdEnVuZbWHyflT81k7ZRQqo+WVsn8+UQMV
	 lRa/kOifXBV5Mbf8hjLh8xHhVdVUOqaSGX3vItriVU5QDGzAW32X5ZmchpKsOne0kfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=erqFqVawVO5JWIlkFRt7XSARlkgrx+IN+sYh7a5xpOU=;
	b=J1XbV/Z8Pz8sPC1SCwIyYkigjhCMMF+MaN55koCs4nqojp8KjWUoR/mzkxfAdXnLO2FR
	 b8uECDwvba4nNZjRtli2yfSTlTupz02lPryi6CSGc5X8hl2I3p1aGAoaqk7STpWu3Hxgi
	 AiJf5pRLqFmTME+Z4NtAeqRBf1pXUqV7i53yuSGtfi4jY/fFZbbLAhcT7n2IGHGa38OQr
	 DBXKagOHdNhAbR8F8K+sX7wLjT85EGGmcolrJoJh7OeGtux4Zv4F/BVvKBKM0+PDBmSHp
	 e1jUJaVpt+btvY4lUYSi+arsHPLXiKa+jUYdVDMW9lEeAjbxyHaJvMP1GVpb6hkukAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7uMGkMX;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AD606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 255AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7uMGkMX
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso291734a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792738147; x=1793342947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erqFqVawVO5JWIlkFRt7XSARlkgrx+IN+sYh7a5xpOU=;
        b=i7uMGkMXscHjhDENCGznN0F0LdwXhaeeK4wgq1V7J4s27ItdUdgiunUqSxsF8PqGG/
         RDNvW27StQY6+J/7pi2NNhXsIBii5GWnzc0xn9xTKKIFh8JsYVTB9OmSKlOBQxgM23++
         1qayxyHKXlS7JCxOnpQwsMiqvhs/BITHAtV2XcR+u52UGYFT99pDYDdbrT2EpjGofscq
         Hy+ASifE6Vm/184hsyDxfFrP2DfFgsVzwMdjGBP4X+j97Afa8pEqJ53zMJ5TI7nLRVXo
         OnffgizhsnSq2tku16pbj2V2RImO0esUxWDeT5yDhDMEzAn5j2FgguIN3aVETuFQaB0a
         d08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792738147; x=1793342947;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erqFqVawVO5JWIlkFRt7XSARlkgrx+IN+sYh7a5xpOU=;
        b=0a0RB62Pu99Xt/gV1Yfd7Eg4YSHHLwUHjypp0vtn8LRe3Egv+Syxgie8ANUaQgT9lu
         aQMDyFlE1J3GPR6ukjvzF5qem+AnbC8I3ENxfG6LAQ8syM+PKtdd2+bpq7K8M4kOIpiw
         YQcYL4k5PR62qLu93ylr4jCxPUEGeFDbTIZ5RbVWUZSHRd2ABT/ZPsDexgqnfWwC/iVO
         aeG87tLHJ3sEWYXFW9FNEF0E4UuJ23N51HuQYSpKB6yu73oJiR01aApaR0w66dDLyyxA
         Q8808CNp7UI4fkDdDu61dADD2H8phgWYADw69EYZLXjH2sPGmYAg17EBYIZt/WlYekvH
         ryKg==
X-Forwarded-Encrypted: i=1; AKwUvByD1IZyCnx50AFPwklSS0CQbUaXHlUNnIvaDnYZ0D3b44Aq1CfJvVgkWftrebrA3hoJOgvSl7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhPj8OVrBK12MVAHQWguY57Nfxdyq/CvX1kM6PWI84IK7NNVwh
	Fr8sLVxEJaIWUwxRzML8sHqrk2mX76jY03MWwtIbxfvhwRIpECX22atL
X-Gm-Gg: AYBFou08i9hwrYZMMcoEhl05VYp+0DsX4f2rszr1Fb0jd3+T1o5DYQs6DtsfKQS/nsJ
	h8oeI8hccxxiB9IATPYfJQjPztTLXd+EZAbnP/+qxMaNphkAN9zKDsXy3TAmAnv40bsJVogfVmW
	oFfZRc+gK77tvxOA3bNzy1bo3cYNaQBBW/fFg8sWSS9m1NNw9pc1k17fuozf+gm3aGnnqShb0qa
	zjzxmOgCQbtmtZVyOfXTQJSzFul7fpnDOk/KhvpFzLb/jnb8pdF9Oq/ASj6iPJ6FnqFQ8n2pCiD
	XI17hyUfrEE7NufeF7Iyd7bY+9aodnwebrtqiWX8UcHRhUga0qfekm4n3pR8CfdSZDfEtG7KdSI
	a3ssSb4BPJ7jETu07RF67H9/Vfth5aoUkNMuYxOo1rRgJ6wmv40Nw8sk/hlHj7iXwxJQ330t/sE
	UWeG27qYnReQ4s41qBZ36TEcOhFSddXQM82ro0sfHMUE7ed9/QsU+ct42A7cdmWKu4JnWHx3hCo
	w74dP2r/0ijF/PB3l6B8BEEthx7WxvcRjzUEEduVuH37NiVpwGGjQbYA4PsIl7mpYge0CmgFboe
	GZP3faKtbIbAa+2tyGfYXtTTm+PvN/ec7xigXdx66MEZ
X-Received: by 2002:a17:90b:3904:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3adce45d61bmr1003380a91.38.1792738147399;
        Thu, 22 Oct 2026 23:49:07 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add29dcad5sm615871a91.4.2026.10.22.23.49.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 23:49:06 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Guoshuai Yang <yangguoshuai@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Fri, 23 Oct 2026 14:49:00 +0800
Message-ID: <20261023064900.64877-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179268155570.3135.6366960419287611684@kernel.org>
References: <20261020030450.7170-1-yangguoshuai@gmail.com> <179268155570.3135.6366960419287611684@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 03:05:55PM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Is this reset reached when the outer TCP GRO aggregate carries
> SKB_GSO_FRAGLIST? It only runs after skb_cow_data() succeeds, and
> skb_cow_data() can fail on that gso_type before we get here.
...
> The skb_copy() WARN_ON_ONCE() itself is older than this patch. This is
> still the same stale outer TCP GRO metadata problem the patch sets out to
> fix, and a reset placed after skb_cow_data() can't cover it. Should the
> outer GSO state be handled before or inside the COW step instead?

Good catch. When an ESP record spans an outer TCP GRO aggregate carrying
SKB_GSO_FRAGLIST, __strp_recv() places that aggregate onto
skb_shinfo(head)->frag_list with SKB_GSO_FRAGLIST still set in its
gso_type. In esp_input() and esp6_input(), skb_cow_data() then invokes
skb_copy() / skb_copy_expand() on that frag_list member and hits
WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
-ENOMEM before skip_cow is reached.

I will send a v3 that unshares/unclones and resets GSO metadata on any
frag_list member carrying SKB_GSO_FRAGLIST prior to skb_cow_data(), in
addition to resetting GSO metadata on the head skb and frag_list members
at skip_cow.

pw-bot: cr
