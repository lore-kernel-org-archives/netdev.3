Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992468;
	b=hSZrWHeN6xTvTRia9VArfP8CaCqu8AiytJDjtrGg34Ok6xpG574LLbUMNJvgS48C3fYu
	 9084syIQ3S/Wu2kV40QKwZ85unlDbwYp+v0R9njnRMt4caloBO5PYJRyEhC/daSBNAR9Y
	 yJdjyJM0a/sk3/8gNEDqkul4kxzVSl198IIdTRgw4FWnX2XsNSp6//mUhx7Up23ChiKVn
	 HSuF3uLg4pDAktftvxdaOIqsOBi9kbpxXS+b/0tr+YnooiQCVEjTRVj3AG26Kokwv0YKl
	 qKUZwfBzNT2m8yFFTe7jhIn8KsKHzvvJ+DGE5ARIZVATQwD4GjNNhmxgSDziRDtzWng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KJHbuu9YNunQc2098aJOeh/4wneftBInLaZd5ecyQ20=;
	b=NnJ4Emwah6bbw3/78iA7EzmZmX55sk7oUCXKKPg6iKq/Rf782/HYjjK2+Nc2SUQC///s
	 UVaS9G1Xhs3FPFdtW5dpBANN2ApGUt7uSUtVVKm1kmI3ORgGmyCpM7f7KJwI4QAz5hbve
	 0nqALf8xIOois/PYDS/coAn0ZjoyRt7LQrHPaW329jPuzZx3sLv6Ij1b+2ler+be52Dwh
	 h+F4WhVQfT7o/j2gJi0zqIj3V+k1fV8l/lhFgiTgU+e7HXIBBUk51JiKMSfrmsbu9nh9Q
	 lqT8rHfy3WecXjfBzU5+5ZYF4O1Fq2T/3HOHQ159pEAxH+39eGjq7y85BxgH7QyaXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cg0E+dri;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D7606A31E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D06D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cg0E+dri
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-188406bb948so1925593c88.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792992467; x=1793597267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJHbuu9YNunQc2098aJOeh/4wneftBInLaZd5ecyQ20=;
        b=cg0E+dritt0P6TfxAW9Q255khPeEmu+69fU8a2+/61exzipudfLtte3lz6pHT99rWJ
         NYh0W4TJ029dbTawErQ+RMpBmQSz611482As9+CYIbrL8/dA1OIcBJkDJUQtVhq3uKft
         8Xho4cBVbfyF3g1PoekWa2iOGxAm3ryDdP3tigjYTJU89NCwQVhS7FyZ/CTgfrLFDkts
         rbNE2r1zXGpM+8Zn07zrtdJ8ntU6kprsxSvad4T7fL3WFTq4nXGqK89wr56ZdHihhPSN
         gebvQ1afjV7bvIobenNv1K8k5v76Yd6zWZXiWvWLM4QKCNB62wf5aWZ1/f3BsqpjZdOV
         NA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992467; x=1793597267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJHbuu9YNunQc2098aJOeh/4wneftBInLaZd5ecyQ20=;
        b=FEm/gJkfwYnzx78OmAcC5MHXylc/p1JzHyXGPm2WjFrHSlSlj/IoGE2UHc9eSIyGYg
         /ZY4rNSlnABgZK4eJMyEMGORSM835pVtUJm/z4Or5y+hGVl+IzMZAilepuMytiFn04Iw
         wZz6nOQgk/NjUUwP9DPWMH7zlvdUVLdCPq586fsBu0VgGvzgJH9YdbBmvagyIAOluTa5
         2ZzJscKg8qYv5i7lfQDz3rnhnMSGDvjzNtuOAQG0k6Edr2mesCYHCeul92o7hvx5iAe5
         s0P8b6lrJuGSV6Ib9DFUj2PvVt7d1gH5/m87bv90/4JAt/TfPcQBGdja/KIrX3aWejjb
         QtJg==
X-Gm-Message-State: AFq9FYKmJoRnHXrdUNvLgLXwL5WYiEhmwWk9BpEuuVw9cBsEm7UAR393
	MhsN3m/zHMUI4xcJE8ivb0k0G550z1AMi0tyijTs+O1JroDhLykpNsthIrKRAd1KATo=
X-Gm-Gg: AYBFou33a3LbRztJ422ejakRdrMpfvk1ypuJf8aTom5sfdpjJY9/T6lJkXoPvSzJDGR
	vyZ2nRnxchoLcGEyj0dJOjhx+AYPeW1YxdXaS5H7DSiJFWN7Cemt6Leiu+IvAdWAe6EyJ4jerUt
	rS1SqvE2ixxizVstBwKlCPSaVvLSe79FJQzGV/0I4Kgu/9YsjfzBGC3ajj40zp/eBd/cj3i/6yf
	ZFgY/777M++6TBi8/0IMjg+uYGzTOcSxWfNfewFGx2dGmiruC573UkphCyIxYJqJMayBZoGfxtw
	xSSarcoABgFmgZNc957zG185JcDbvU/tmSNRgqc1maHWbiE4QQX1+2yZneDxw9iSv7KMcU3xWjd
	Mf4gC4bHDDepgEdZvemDqeudhZqAFhbIxRzRP4ZVVTqB6nWjNJOuFu+Wdw1yH7otPFy96nU5Jlj
	ImbtS19C9od7Lomr8F3/pAAsEVg2Pobbh7IyZagTUopumy07+iD1wXbUgADPKKIp0ywjkjoQMwJ
	W6ffc+ZOpHE/HyZY0NIT9WKowCruHhR9eav5D9HdM9v144avIc+5P3rTDhEgWqPmfFGQNt+Qf3a
	MIFXESnFIq3zos0TcNR3QTzKvQ==
X-Received: by 2002:a05:7022:3a09:b0:195:76af:b810 with SMTP id a92af1059eb24-19935fc69dfmr10272975c88.25.1792992466519;
        Sun, 25 Oct 2026 22:27:46 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm29188566c88.4.2026.10.25.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:27:46 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/4] sctp: don't treat an I-FORWARD-TSN as an association reset
Date: Sun, 25 Oct 2026 22:27:40 -0700
Message-Id: <20261026052740.187459-1-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179293012867.3134.16497481637722705271@kernel.org>
References: <20261024120627.837568-4-tim.budding@gmail.com> <179293012867.3134.16497481637722705271@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 12:08:48 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> With this call gone, sctp_intl_skip() now sends
> SCTP_PARTIAL_DELIVERY_ABORTED for an I-FORWARD-TSN at the leading edge.
> Is the pdapi_seq it reports still the message that was being partially
> delivered?

[...]

> Could sctp_intl_skip() pass sin->mid_uo (unordered) or sin->mid
> (ordered) to sctp_intl_stream_abort_pd() for the notification, and
> keep using the skip MID for the flush and sctp_mid_skip()?

Thanks, this is a real bug. sctp_intl_skip() has always reported the
skip entry's MID, which is the largest MID skipped on that stream, so
for an I-FORWARD-TSN below the leading edge pdapi_seq could already be
wrong when more than one message on the stream was skipped. For
unordered streams it was wrong whenever the abort was reported at all,
as the old check only fired when the skip MID was larger than the one
being delivered. This patch removes the path that happened to report
the right MID at the leading edge, so it now shows up there too.

v2 will add a patch before this one that does that: report sin->mid_uo
/ sin->mid in the notification and keep the skip MID for the flush and
sctp_mid_skip(). The selftest will check pdapi_seq for an I-FORWARD-TSN
below the leading edge that skips two messages on the stream being
partially delivered.
