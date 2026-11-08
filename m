Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149948;
	b=nv0tco6aJIF3ltTkqP9l6rVQx0Z+foX0krkYclybyes2f88TNDCPJtuSsI//wwgOnnID
	 QaVAJyz6ThTNHqF8Z7LrpWCIVLRLlB3Micpzc9a52fXtbpnwxK+MPQU+gvyN1uokgodY4
	 KRYoRbrf4iTw1Bnf4j9+z9imzGjHzBaZ/a0pU24z1pNGkkzfm8nJ/nH7e07zn9RmaT1RH
	 9+6oeRzC7CL+qfW40rFq2TwcaX+eOqVWy6XEDs2wMMnDKm/cgpPfy0fqMT39AaG/eUsSd
	 pg8EjT1JfCUmpdxeZ+2pAnFr9H3mEsucxmbGr9/822fTQRBcBk0eDhEDKT+kOiDauSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=46GXHeUALtpO4O3TOALhIC4HG0bGJ4xyjvuRvhuOfq0=;
	b=KJ9+cE0voCmEvEwg+P7NFevn7RoVt0VjdgpyXuCTOIfka1dXkYqnoVDHB9QO7HOgwfPD
	 cEslC5hQNjrk1SsEBZQEyonXAETP3xIJ4tljkrYwrvS0qG6bZ3Z00mgqw7YFmdxxaRvHs
	 0o63HJ/FG+KozL0Y+RcQRuOMNdCkovnPgpsEWAm7Irwiqgvg8176XT6dcU66sGsIBKIiD
	 bSy4+WGwCbGBpR3sDAqOvPehGA08J9ORDucWcDV+Wf4Fsoo/cCWUfeYLv8n42vBPeilOs
	 AxDGgINVQNvf6HmtbyubtUuG29emikyiWthUsxXXPKJWgGzZ8rnYAh71XLYGGS4vqFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+mgnbqn;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAA606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+mgnbqn
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36ff9c9da34so204324eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 06:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794149947; x=1794754747; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=46GXHeUALtpO4O3TOALhIC4HG0bGJ4xyjvuRvhuOfq0=;
        b=I+mgnbqnq8NSHuqYlXQCBRsCwEE4OSEQinRr8N0VZR0arR5lJW+qfCv8UvBUUbAt1A
         iuNEdhaiHT5wbCtr0NgDNbh48EXeKcpGcaJZszJnqmKYY6z5U3E7veLLoAjgfQmxcYbI
         JmwYZwMdrk6PAc5Yq2opy2NeE8Ns4p9GNTn5qsxTBDmYfYaVZgbenDQNJpseaGv71hEL
         IzcqwNqVhVdURUQvExrPOvJSU09getdEEbZeaHkZ//MDYaHZJZh758RQ4kLPXtqv0tlB
         c0JPbzbwIdq925YL/RhIsc1eAj6H9AHwfkKLa/2RLe2lI/PDG6FNJGBWO2PgUC01qL0i
         lWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149947; x=1794754747;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46GXHeUALtpO4O3TOALhIC4HG0bGJ4xyjvuRvhuOfq0=;
        b=XbUES+Qz4P/C98oEGmiWfjvmqqM8feXfBm7lprEaxZRJduXTjFGVDR4gBzEaw9O+fZ
         axG6sG895Y9mi7aGuMPkff4htIE3Dt+SxCwNgEcMbxNVibJblJzq+Fn/3nPFBJ2MPn5r
         SLtb9KcxyW+rNgLRKvZq+fNr/HUbZDjS9rr+r6XVMUtqKsWWi6Kp6fyU9oPAXTsh2bM2
         DUKXc/EE8XkLSc1Og1RJrUA98gLooz8zrMuqLOzsPUowP9txHlpVT3tDuv7sWYvHTZ4r
         rfWcvzZNooxpDh3e9EdFxnqoj6Tq7vCOGO5D+SJ7NAbuAoU9Q3VI19mF/Cbfvd3o2CrQ
         8cSw==
X-Forwarded-Encrypted: i=1; AL+hErHegDXjq3lnTI1QXiHvKUBgcbJRnHBXR2Aoi1e5ywz0VZjVnoMEkbWXJP/E73ayJm0sf8BClC0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BODLfaiBy1EZ1AbePoiBt3xGxCjdNPoT2KrZmlhjVh3FQcKIn
	ZWXbmqpeDYVA/g5dtNR7HpuFkwM+UXvoJxEntbsJnonkm8LbkF/UKkU6
X-Gm-Gg: AYBFou2q78Xj6FMk1Ld0dxUNqvZhPQ2YFP3Lt5ldZLVLEGCLJT3byQosUPo7OOadO11
	6LBzlJFAoOHUn6YSVHYwof/9RjO4xjDRD5APFhndRoMfn8fDNlnHDLQkZDzvbcMJVcBQkAwb8mH
	rBOIjW1y65IKs9MiSyMpQ3iyF3LG5fQt4r+snuZ/GF9WjQld4mqElkOH3jMO/xGQsFe74BniyT3
	NskJGPNUsnakGPdOF2gfH68YPW4MM24u2Qwi8I34+/oaWjJ71us/3+p0tOEbaARCtdSKCgxNAhC
	AeYl1ULeZBsHHGcE2mKs40klx0EMXl2+4o6kruaw6DjQdeiuKdx2hoLhiW3HBLrrfchq0WWKO+r
	30a1gkS308DTiGmg/MBmjQAqrTwEurTzJehfhqEuTgiYs13Bfo2xIRqK66bXvqyu6Qp+5YAAnYD
	Y71jSDXNWohlHL0tf/cpR61VyuvXBoc8In7+TCQH8TP24k1pR2Ez/dSJ5fMDMuGDMqVjULVPuvN
	7J4Zd+yGZ3w6a209NoGRtR7Lfet1CqeI/VOh42GES5LrkRRMgeAlOBi3WaUuicw9yfv+n/tcETz
	j+TKBsukmi6iQb8ONkDU8J9CdYX5sSSmOrChj0WXrNdqzv9y5beBHsFBjpnVVK5rKA==
X-Received: by 2002:a05:7300:680e:b0:36b:d3dd:2e85 with SMTP id 5a478bee46e88-372575c63fcmr3296545eec.36.1794149947219;
        Sun, 08 Nov 2026 06:59:07 -0800 (PST)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265c06c61sm5679879eec.14.2026.11.08.06.59.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 06:59:06 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net-next v2 0/4] tcp: fix tcp_base_mss on passive
 connections and test MTU probing
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <179414895487.488859.839196891969031483@kernel.org>
Date: Sun, 8 Nov 2026 22:58:50 +0800
Cc: davem@davemloft.net,
 pabeni@redhat.com,
 ncardwell@google.com,
 horms@kernel.org,
 kuba@kernel.org,
 kuniyu@google.com,
 shuah@kernel.org,
 edumazet@kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 panweiping3@gmail.com,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6A5F2D50-D257-4F6B-A1B6-BE08489591F6@gmail.com>
References: <20261108-mtu-probing-series-v2-0-355d6490c3db@gmail.com>
 <179414895487.488859.839196891969031483@kernel.org>
To: netdev-bot+sinfo@kernel.org
X-Mailer: Apple Mail (2.3901.100.1.1.12)

> How the issue was discovered
Hi,

This came up while adding packetdrill coverage for tcp_mtu_probing=2.
The test work involved comparing the initial send MSS and what happened
after the first probe was acknowledged on active and passive IPv4
connections.

With tcp_base_mss=1024, the active connection started at 1024 as
expected. The passive connection started at 1460, and its send MSS
dropped to 1242 after the first probe was acknowledged. That led to
checking the passive setup path, where tcp_v4_syn_recv_sock() called
tcp_sync_mss() before tcp_init_transfer() enabled MTU probing.

Thanks,
Yongjian
