Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515270;
	b=PWpidszifNsYG+h/4eCUgCsfHmt6yHXdMbM+yWz/0UghuDS9NP2/O7OX2v1QYPlplOGg
	 JD4SKQ+UK/LflBP4HLjktbUqopWXMkaFzJSzvq70Zt8cCFR/RtI/ebqezyevt7IgqbUYi
	 SlLsBWm1EMJVFwSUcjT3GokH7vTDA7nXI3qZxOohf4JHXSNvXj58D5NgW09RrpfqbqLC4
	 aeplP5X3x+mbfhsGa50Y8+OzHTamdw1Xwmd1yXLGWtguVRwCVp8K4GNY0QGIzmz1bdwvV
	 eVpbIlpN1GKh9CFlp1L11IKnAm9zIxj+Lgebo+bnXCmRlPiQJqPAaI5mE+qvLR+Bq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sqzRA9UrTkSrnhG0afFV62l+ePZ4vnCL9ohyTPGZ/WA=;
	b=l+zibLOxvEZ7xTSpYT1rP/A7i+9f3AVKoCkVRZjU73EgH7a2lUcCcvNTVxME41gIn5/K
	 rXdL0/tJSJ+ZMZ7wSE8jEAkC19ztx7vZa1iPzqORSIFIAq28lHfAIqf7aoBhmHO3Bi7wD
	 sRMC/NQfjTC4oG9/JM+rzyjsSrUBhpdVuJLYASD0DarVCpKz76Vlc2v6HBBXyistV/uCU
	 /sP+oeQoQIWfpe9gL4L8l3UD/UFnzbJjzifJH8jh2UK6qssfcCP8xDHTdI2q/OF008F8C
	 lRN098l8BfbY+lY5gYfC66MGv0kzA7iufY2k3TTXpXi9AXRRknNS9KZ51N/GXD/B1rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSXY6HrW;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E7606A33B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913E7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FSXY6HrW
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso102325e0c.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515269; x=1795120069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sqzRA9UrTkSrnhG0afFV62l+ePZ4vnCL9ohyTPGZ/WA=;
        b=FSXY6HrWohav0xzx4hrdId11gMGlVIU6liGz3RGbsAhmAcNXDFu8lnG5WTM9O44qGM
         eD0cmTPlZsKG9NPyYgOvMYMNM4JAQYGdl+YvxzAiNmM9hAaLa9V6Q29clS98xl5BQ+xj
         qi5rIDGPi2Xcdu+WpFwQgBLFgF+HTRRdHDYIC2WC/L1U/5axruhO5xu0XDZnT5fksT9y
         SrHXB8JwuZj2zN8A6Joxqp7ick0aV4ARCpGO+H5osp5kX4dztAfO/UPwCrU/YbhcQb8e
         ZfBB6+fjB8Co7knW/Wr2fN3RA04egkjhu4veS/V7ewnpO3rez8Cw4+3pqBgwGwrlZCtv
         TvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515269; x=1795120069;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqzRA9UrTkSrnhG0afFV62l+ePZ4vnCL9ohyTPGZ/WA=;
        b=FbsGGHXmXSbh34ge3PpiIAywyQP84ZtnJzxWGkOQhXI+Xy67gBjrtnt3jKtSQJt5S6
         fCnc8lNt9MXYL88j+DOISMNhy7MCdAYCuq5nvEO77mjm5j12xLpeCi94KiasGjeCMAnb
         i5BdnHYsULHYq7/T2pQG8+ERAPqxJJVW52Dcx4Rfm7R2CMA2m+r1XjnrSQQT2pvsM2y+
         NmJwbYnpdq2iEbyCOwN2LYOfYZiLJGtHed8m5mnrrTJcrLBacHdN12fJyCdJbXg+1MJ3
         60dxe8pZCAz4FTcYy4fz59HLNAoYckIoApybaOicWJkdMD4UJ9QIuhPFpCNpPxbV7w/P
         vcsQ==
X-Gm-Message-State: APuU4Z/ZDW6Ir4uJtnYMcHoqiZm5w8RJnoBt3wBu9OBbb3k8TprbJWzs
	L3hHy4RtB00OXxwLUVSduOjq0Qj0IHVbNZFPE3b6qUE1BpdxZW+BJFHC
X-Gm-Gg: AYBFou1uirzsKUAQY78EuaeqpuizjomJC0Y5GhyEg+Bp2U2A2pUU3UyoqWtNxpld+aI
	V3ekqB1/qA0hkS11SMfBVvtimodWad/dTZfaZoodsoxWflA+wfqf3C0e75CoqkLu2wIF5IAe3To
	rdbZwOH3/ii2CfLE/nuxO1jMbG/MRMimf2tB9VZfxR2HfDLSvfleY5TRJE+8FjUvNaWz9C0boI9
	JtXj/nXPrc+nEOzvyYnke2w85gs+IJt0VEKPM9FJYMjT+j5kcH9P/2He7UHE4ANaglzXubiyV30
	hfuw2sJcznBgCEz2TUXe78b7zicLT77CsSAIOwkFYR2q6EolOu1v9g9S36nAqwCi5Nkd1kmTCta
	aV/ps3kZPKMtFahK+4yzI4T3DVQ1yMfBKDvpXcW74jiCu3tBq3fMgrcJwGOqat3De6sdLbRzrOG
	k6y3XO52XC0TJnMCfvxmnTBHNmXNUel1pE7GJ9skY/LTsGdpY+EaJTv+S9eHjF8ojPxNH95hTMj
	3MGk9aUh93vlQ3461fAY3IgL6lWcsXI3ZNH9MML7GoiDphlgkLQYYe09DDkRUSVNFAysl5AlhOf
	lbY8cbVz8YViOjgfB+AYgGSPCGcsQyIXnogh+LCa9HPC7j+Nl/M8Zc5RYt90U7CWDQx38slWrGZ
	/azQ1cXRrqsLWB5VDLRN3j67hwIcUbqc4a0I6uhjeEV1QCot2GVwH4FNH1SJwhaF6
X-Received: by 2002:a05:6122:249a:b0:5ea:c727:11fa with SMTP id 71dfb90a1353d-5ee344ed328mr127187e0c.0.1794515269435;
        Thu, 12 Nov 2026 12:27:49 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c779474ecsm367275241.2.2026.11.12.12.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:27:48 -0800 (PST)
Date: Thu, 12 Nov 2026 15:27:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 steffen.klassert@secunet.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Hassan Sultan <hassansultan@google.com>
Message-ID: <willemdebruijn.kernel.bc632ebec32d@gmail.com>
In-Reply-To: <20261112111619.14ff70e1@kernel.org>
References: <20261111221129.829218-1-willemdebruijn.kernel@gmail.com>
 <20261112111619.14ff70e1@kernel.org>
Subject: Re: [PATCH net] net: gso: fall back to skb_segment when fraglist
 cannot satisfy checksum
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 17:10:33 -0500 Willem de Bruijn wrote:
> > skb_segment_list() keeps the original transport headers and checksum
> > state of its frag_list members. It ignores the checksum bits in features
> > and does not initialize the SKB_GSO_CB() checksum state. This breaks in
> > two cases:
> 
> Does not apply?

Will rebase in v2.
