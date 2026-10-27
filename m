Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113351;
	b=PcVAwJPfs9RzIEin35JesUPQ74BuQRHd6eR5S9zy7fsRy7ILyXDfOfmQ2DK8F422KQxY
	 e9Qc62fK1qZRCLWE9iSsUeNYSSeeo2xFrDDE1akxgAsYTyc1RP27B7kktaq8Zrqnx/0nU
	 5XU3LTleKCfj20xKABCGxJKHXnjOSu01/B+aBUI3or86WCmZB5nIITs6KV4wy6XJxzaqH
	 v+FkzhnXeVwgpTuJG0dNbgyKSQ8qrPgctSVlhBKzpmvgd942KH3My8+GMEYAU7aezzhUU
	 v9ptqZGMvvopWHt00mSQCoTu9by9NYvwK8gTHuwD2Tk7I93xzluF3rvQFV3nEI2UXNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HGMtvMUKn1QVhLCJSoyj+PiRyLHwn+umCHA4XuRfwu4=;
	b=Gg6XwTuKVEv/iRLesMhCeR3qc/1CnVWBwL16NsKTym45yyls3CP6BPipZL/c4qXQs2XM
	 4l5qQwrCbwkM5zfxuHIeaR7dOH+Crw6KV4s9VM4JW+y8QBVybIN4ZZlxOnSggUOj0A7OC
	 5uhhPRrFE+o2ofkKNKfqreCFQe09Soz3Et3TooqzUh15aTDwOCXDorT8XN+Gbr/uEpQQa
	 F0kvfq/yXnIds9uFslzk4CQtXQrEdV5MS2hTi7KZpGT0dmtqTjI9jUQ68GqkLQQWdeixZ
	 Kz7JtWaRrnADP/QVlqcX/HyHCYFzny2B/rzjy5p7pFbn6wWo0JTv1INEktsIevaZ3qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V04qkQfl;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F1606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB9F1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V04qkQfl
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so1299787137.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113350; x=1793718150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HGMtvMUKn1QVhLCJSoyj+PiRyLHwn+umCHA4XuRfwu4=;
        b=V04qkQflkGLKDmKvJ0zTwrQh8Jj7hE+4GupV7lkW9yYSqAFSD+gpyQJlIzmmPiRKbq
         mL3klPhaOsleghQq9oRRmix7ADtuVP7LRDDjpaxMZVlZ0E9LFRODKeZ86RthZR+5KrAk
         Yf0A3OuhGxVeV3BnwqdTCtD6g/0N19lGVKsz1pgB1CmnQcNMIXq7uNS4qDU4YVQ4sHOC
         2c/vb7M/eTlovlW9d8YC7DYKyCNoPE4BYHrimajW1aHQFdOystT4bVV4r2+g80ms1xvb
         /fuTtViKBdXDkBw9K/fVjt8slLN+5iVZl5hUeBUxheIJLFtBUAkwxgnlrF3ywnWHNtUl
         xvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113350; x=1793718150;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGMtvMUKn1QVhLCJSoyj+PiRyLHwn+umCHA4XuRfwu4=;
        b=giD8px7RQhf+auqswLm1LC5wdClQrFmHR/KHojJWF9Rveyv8W8n+16e0iJNeScW4mv
         B1b60DrpBvd+33MDKhf9lJduSDX/wp5FaG2MyEdFUTBIaVwjxlMU9wzBv7NKKK7KwF/y
         ACCc6MzowCFstXJ988/9lo10wvPbJzDKHQp8X2mm2F9jkK4EKgIn40qC536w6QrB9Rp/
         +HN3urAxg3Xniao/9H+JaTlkptp4dLP+uN1vniH4XiN2qWn5uEJzaFbmxUVvOT8vzMzd
         RALffA2rA+pdwpYORyBLHjj3gFcL7dczELgVS5nxw0Bvw1oYbAWkFXJae2JVpNnAWW24
         pFeA==
X-Forwarded-Encrypted: i=1; AKwUvBz3Vum76fb68e9U6xpL5FjzOU6koGKV5DBLgBRJDULJCwOKRwt698NO14L33ZAiv6SKBem1u4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpYVzSgsp8vg6ehjhf/CojDWrrIxgwYq4Tjg0Qvx9CUMke4BWV
	Yytab248dpFW66hsCGUzaNA1c8Ff5Z/EYecYGV3hUU/14wFeXCmasWM8
X-Gm-Gg: AYBFou0aKeVLjSwte7RYOop6NrKSEM3Ijh4IiHrqbu6ptW1WpJA0l86OlTzUziqpkXs
	7MDT0JBOl1ijCJ4cqjh6CybFmjheabQ4uXSvWYMSXCfOH3KOkT2cF1fyiQPO5RVCTU9zkVlCf6I
	rswVNY8dD5yN4De+6Ex8LAoM+IpzsY+SWHysOayRFqbOAFa+9aPXW1ZqcU2TdG/0kGLlRsa1iWL
	QMwj/3JeZRXyZjsEJ+dBXzCpSmxtP1yVDSQKCM+0z86dpYIzRQ/C83QFJaVyFasrtdoeOPGo/Zh
	5bCXaa2410CW7iuhm/pTFaJ9UwZh+RpE05g4xO47ffxuEtOW8cEmzkyCX8HZAMgjHSKTf1Tftex
	k+n+TJTjBRxZkRd6uzDEmQkW+tybufO2YfehiyF7z3lVA9NUGxXhN96joXhlZhnRoDcYEIe5iqK
	tJTuzqtaUhHZJrggqsbejp+jlCinMd1fAG6G1dG1uqnbPMhnC9gWywJw9iM/jOGvaVps06kqZNi
	coJxE3zvVuIAeX/bMyibGKLKM1v85RffrbubJ+cnfSFQ0e2LzZbniLiMkaB9zHGAB6N0ZRNxjtR
	jVj9XBP1MRniF9Ezs7z0Ud/bGhosclWZ9jv6a8yqykuJiE6rWFTSdNYkh8iEctN3XT2S3L31+/A
	yEWzkSTiQ7DjXO0ob0ZTajttcjzA4505DYqYG/1IX
X-Received: by 2002:a05:6102:50a6:b0:7cc:23e7:e743 with SMTP id ada2fe7eead31-7ce5ccc0438mr3378821137.15.1793113348309;
        Tue, 27 Oct 2026 08:02:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3c44ee7sm2664693137.6.2026.10.27.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:02:27 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:02:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>
Message-ID: <willemdebruijn.kernel.1c62007f7ebd4@gmail.com>
In-Reply-To: <20261027082604.1485903-2-edumazet@kernel.org>
References: <20261027082604.1485903-1-edumazet@kernel.org>
 <20261027082604.1485903-2-edumazet@kernel.org>
Subject: Re: [PATCH net 1/5] net: add eth_type_trans_careful()
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

Eric Dumazet wrote:
> eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> NIC drivers always provide this, and they should keep using the fast
> version.
> 
> Devices looping skbs from their transmit path back to their receive
> path get skbs built by the stack instead. Their link-layer header
> might have been popped by tc actions (act_vlan pop_eth, act_ife decode)
> or OVS actions (pop_eth + pop_mpls / pop_nsh), leaving fewer than
> ETH_HLEN bytes in the linear part. eth_type_trans() then hits
> the BUG() in __skb_pull().
> 
> Add eth_type_trans_careful(), which first pulls the Ethernet header,
> and returns a drop reason on failure, so that the few devices exposed
> to this can drop such packets.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
