Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899824;
	b=uHhK1ZSZJQgS9/2V4BUa2D1kvKxZeLisYPNjwFToADDmyKavJp8nyrdJyxioAMyBfCg0
	 Z8ggjEQeA2qbPyjzEZ02LgBzAVnasdRfRTc6U58HoKbqh//t4R2VbLq1nZheqehOi2BjG
	 iTCUk0j/4HI2JjME97t4rFuz8t64O92QOhiQ/Otk/fE/EX7doEYoMdRTs8W7fK55tUCxi
	 4XuvwZEFSyw0r449nSctUwRG/Vzkvh5XlwgQLKUI9dR0J/bWm8Rx4hO3OnYOrMQ41887f
	 gJRLCEpYWUFl2WRf9jXJkdP5pzETWOpEO7X9s73atE8Far+gs+Txa5XHZQ6s+L7ZadQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X5OzgRH/1V88QEQk/qEsTmnI1GvbJFJUj713/504BL8=;
	b=Rv8wl+QpkqI6/ClsDeuOkvN9P7YHRdVVfVah1NIswkocUZhAKt+FaR3vEM04xIvBl9E6
	 Hv2DsCZVQB2FqjyU1JvvJwIa0Erg1Y4xYu82w1FOFiwoCcfPBIauOEmagYZg+V12Nso7g
	 F3aT6PypqgWhvfpZ7CtCSVFClTSurq7zEbzxcyXlTlIYEcW4zB3MLtmrVT3auoyfmC6NX
	 98oBzFiSz7ekPZyfW9X0H6UTMb1pa9VR9orRPNH5RR0aaRnl1jOEhJ1oJnDYxJspKzng2
	 8C/NB4xuHCBsXOPe0zioofutCs/aYqcS3McvJsy6tNoP7mD+Q74ePfhzBQyz7kr1TVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N16Ofwvg;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A5606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2A5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N16Ofwvg
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so7396375ad.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792899823; x=1793504623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X5OzgRH/1V88QEQk/qEsTmnI1GvbJFJUj713/504BL8=;
        b=N16OfwvgmmwPMQDqB+lHEvh+zA08Sn8PNtt5nWqyL4kj7TtV6iahTavuqONDGHEBo/
         RbSbWLe6FJVOTZLHiZQ0tDMURGZNbWXtKXDEae4HcuG2plbenNgJtSS2v6cdqU2WtUL9
         YYglL+PJCqLn5YnHaGVSlXt2KnAVwsCFXsftv+ms8kseuiFbCPnK789lW2sPaYYBKPBb
         gwXEL60ec6G5RrZxvpg5OvyrB/P/MYw1uybQcbtxl4Vl51pcgBMPsHtuYhwi2DAWgEJ+
         wt4qF2p3+n35tCoC7KB+/hjlGuuEURHSl+X7QhLGUYRbHduh095EC8e+aAq9BVn7lXFr
         3l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899823; x=1793504623;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5OzgRH/1V88QEQk/qEsTmnI1GvbJFJUj713/504BL8=;
        b=R1wl+UbUxr08GzekAUXWUwsqY8CJJsCvt2938EBhOw9OMhdYrMcLyJ+bEbcszXyIe/
         oxuP/jpd5CVwwR7QNkBJJOci2LS7IbN7Fz9KO3w2ZlyH0PU6M7h2G1uQN4h6YCmmHlCb
         2XPpSPX5LXv3/yljwuLPb3inG099SygmihJ2SFvamPQGGIauuHXKKAgUkQq6GBh9fq3D
         zL3KbJpJkcrSluHFVbyJVlsQ25I03vXcCC5lzDBheRxWI/qyr0+Yo0zkdehRn0RIfHix
         vTe6a7m7dn6FOCJ9wWY/6fkDdXAu3KztOyCTKGaoDBLrLy7TOG8vMnGU5IVYDdbkTZ7t
         3X1g==
X-Forwarded-Encrypted: i=1; AKwUvBxF5AOX7P+/lLSFdZXRNamfvEQhCblyoMAMSAY4AirRgR30vLjQG0FUPltjQMzTNBfV5XkzqSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRL/4vd/OMukq31xpVzzYU7nUGiAcTFWwiMQ1Rjw2PhXCd43KA
	AzjT8UhNS5UpZ+e6LkSdieqsK4pCqTZiCRBwHokOBwvb151Cvl/EgHVb
X-Gm-Gg: AYBFou2SXIpO0o+rBjkwZRlmFg8zNfGyqOVJwMUJXKMpQB72gogbCdbsxZtVERdYio2
	n+5Dlk0Rz7XOn5f91jGmysxfAHn//eDDZxPxFN49rqqLYCoJfSNqoqY4FQz7anhygmQr7kVvzAF
	wt9Z5cRDEknQn9ODVd/ZBAEb0pOftgrB44EKfWbyZlbYA6nuRZ9XKXFPJd1pCDNX2Gs5avgEDpI
	pcj7Dgl1/RZKNRIuZ17UJtuRBIOjzg2t2bvRhgCzGHN/l8ZISb+2tAyYDpPomT6YpTkMIasMC2y
	5CPRvSkpLmLiF/HHwkoOl0sJ3JniQT8vgN4bqsPtVh0klKUHTLEArTDFKi9tSI00vOjYP32Jbtz
	Y+sQ9AKdJXfsScgifSrYTODhUClaBgx+lk24wTr4clIgupxAGtCDOWdm3LBGad6rIUZisYtz2zn
	jSx87FbmEEBxKtbKT9GgBLHk64pqQLgN4ut5BAfqbO7avcNIOeE/lTiVP5gFVx9TEWTutyp0Ro1
	chiUGn+hpPAAIHUCl3gUbtt5JblRUW33B/o8d441xcrSv6gCqY6gRmFduxf7aQPz7/Oc+7/3AAS
	GV67l52OW2z9NMPNdZKcscO8mw2eDeGWFO6I2vtaMA==
X-Received: by 2002:a17:90b:2e8c:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3adead4c1aemr3019182a91.42.1792899823172;
        Sat, 24 Oct 2026 20:43:43 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:332b:d93b:afb8:5ea6:9575])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca727sm4265968a91.3.2026.10.24.20.43.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 20:43:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
Date: Sun, 25 Oct 2026 11:43:27 +0800
Message-Id: <20261025034327.95300-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com> <20261024141157.59301-2-testwrzwrz@gmail.com> <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
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

Hi Jason,

Sorry for the noise. I posted v2 too quickly and incorrectly threaded it
under the v1 patch. I should have waited and replied to your review here
first. I will hold off on any further revision until this discussion settles.

You are right that I did not answer your questions directly. The cover letter
only summarizes the drop behavior:

> On a checksum failure the packet is now dropped after the descriptors have
> been consumed. Metadata validation makes this path unreachable in the
> current copy-mode implementation; keeping the defensive drop avoids a
> retry path for an skb that is no longer complete.

Let me expand on the two points you asked about.

Drop vs retry: in v2 the checksum is calculated after xskq_cons_release().
At that point the descriptors for the completed packet have already been
consumed, so returning an error and retrying the same skb is not safe. Drop
is intentional for this failure path.

skb_checksum_help() error cases: based on the current XDP_COPY path, I do not
see a reachable error. The skb is not GSO, the fragments are readable kernel
pages, the skb is not cloned or shared, and the metadata validation has
already checked the checksum range. If you think I missed an error case,
please point it out; otherwise I would keep the defensive drop.

I also applied your literal-else and unlikely suggestions, and split/reused
the selftest as 2/2.

Thanks,
Rongzheng
