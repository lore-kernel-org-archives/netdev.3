Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266163;
	b=kNgf81G74rQhhbIVl4T/kOfsSnix0kBCy52O2D70MwLdiMYfFFcN81MJu5eDMx1tQ4L+
	 GJuRfChulKl7ACZBX3t4WouTR3+9DMNfH40nEV2Ncug9/emDNZ/S5yXQ6heb3tvP5zx1V
	 qsU5ZTg68u0VbBbIcwpZwl7XurXVlGHJLO3LJnJBgl0ksrZdFfG5seo18I8nRuUeaAhsX
	 rCR0Jt5G7Tu4PAaHg4lv6qyk+aFgeQzfBxdm09VFtc0WijMoS/pQ6rp5gu59vhTtykMAO
	 5TeR+ffzN2h8Ax0lBdooExEyJKE8F0VMW/qVBXcKsUuzIvDYK/tkIVvJ4pEPElzPrDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=p2VFQ2YdVBVMlHGI8TnDXTz0Id7EK8o66F4F8DkIzGs=;
	b=jfAMOOzrijy67rFFtVniCDqcYHWou26qrs+NdJL2QRYwj8ZLeCh7Jj5xAJTYjAB/nL0G
	 aHwzkGIjHpagLfrBp0jv4Dv7X84lkVJ28wEtH/YEZVxSEsSk+nHC78EYCgnl4KqKEAgpd
	 dGmAzQby3OR9zyl5QKV0gvkj2E78SlMm3JyBjhqzS4hsO+8wF1Euzzm8oufGRA9UIR3BO
	 LSndkJz2zd9hpU4gySxRY5J74Y4334zhQiEIYh/XXSN0jFR825LF8XaUuc/jVLISxwoVq
	 q8oSgllfcL28pT9RU5+A9nPrE3JFRalxiI5xv9bdBSsG40R9V0E8qFtlSb+JJ5ADS/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KPSgiyD9;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D857606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D857606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KPSgiyD9
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1160174a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793266163; x=1793870963; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2VFQ2YdVBVMlHGI8TnDXTz0Id7EK8o66F4F8DkIzGs=;
        b=KPSgiyD92WSi6Fh9CUiZtRObKuwHvCYU1NDwm4cWnnIA7pEELX9rauOCJB43Fu3NOo
         ZXv2LA/8civXM836gZzYBpGx09nCTwZsEJVvMtIl4pcX+uOalxW4hSFtDJ5OGK+owFPV
         pErEqMwvM2w67A5uCdRV3XGUNwpXN0d3/vsvkYuGCLoGk1QQ8fuqpISbH9gnOYQdCB/I
         qaKFdRL6/88+Rbg4x5fZSWnh8exyoidAKanO9FYBcvwXxKPryXFHIrvo/utQVuagAEeT
         chx3n6P+yEbtnm34hjtup5ljzk3z3ZKY1mEbRqcKnGsSHk0f3feGGqoHVtJ6e2eKF+zY
         PpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266163; x=1793870963;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2VFQ2YdVBVMlHGI8TnDXTz0Id7EK8o66F4F8DkIzGs=;
        b=zde1rsu8z+2s6STT+STrJEzy8/7u/qSKzBR5IKUYGlPZdFjNZ+QDsBr3ryr6+cCg44
         h0YqGAbXUTQT1cO7Yjxs5JNQLv89brXWhYXr4Pu/qIqffQTyW3UakcwPB4nAO68EblfO
         AjEmA6UE/Se/8pTu2aARpTEf3zJGdLeKxSUc9IEJrM1lVp07+aE+eX2XJgZ3xLiYoxs5
         +GpKc8r54oR+AcF0Nq982B95q6T1ggL61ZVeGc3/jcjou7LtC1enrmXEQZ7m2s1gyxXx
         tyczmvxZJhW1iVObQ9tSXTHc2zvI4LEME20AoJX9zhyKepSfNFHgNi3v3dmtYH44BZgM
         539g==
X-Forwarded-Encrypted: i=1; AKwUvBxh646It6T6Lu8TH7P7OI5E0O3w6+RJnPm6d1g7fdxQgJe8xJtQ8HoR46joh1yUWnX16zshNMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3rWxJKBoMehOvptruWYrU21qt2vPc3OENujAFMiHql9QyO/jS
	/JPxGf67YgBcebbh5n/euQpr2hAgdvbJqCjC9E5VRGfg4VwM061EPp53
X-Gm-Gg: AYBFou3nAIsRfq+l0m3b1KpB8ETagRN7ozmOvIQwqfQPcbO3jCgyu8YbFgmrBlasYYE
	e7205JiSUcavfAjckpCtGyibdkvlG853tMQkmEZJWekNAMH7j4CctxqGsWvPnt/HEt/EbHk7zZL
	yENmsVYA0OzP6QcOnDqtfMNDXGysetilMcDb3RkUo9nA537zgu3vhrm3HuTQqA+gBI1B69l7xpg
	eRBXyTi+jQNPSWCu3JaPq0OQ4VuQiMYVe9MeayIMP/pqvDlcFkjCKAMPR9ib9yPWHetjvfjNSaa
	BJ6p9wr+IpYvw0Y9zFlYol/xEYNZA4uZXmfTeIoVOP7uantX5RAhr9OGotyx1oRxERK7Vh5Rvsj
	GhxehxIRa0cWUrrAvHc01FTv1xO14dYgm9uc8+2ItNpp0F1AWS+1/VXfBSlPttAiLABQP3vQucz
	rFWNm8TemGvvdIgLZM1Lp+DjL3hpw24+E2oBuuVgQPoSn8iS34na9c1HK1mc1JPMFNhI5TVMVGV
	Q6yVcMgQHTU7KMwd4IcJI+Rcz+H7Oz//bMTqET3smxin8QIJqK671bubKEOfA==
X-Received: by 2002:a17:90b:3c04:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3ae581e8bd3mr3092891a91.54.1793266162773;
        Thu, 29 Oct 2026 02:29:22 -0700 (PDT)
Received: from [192.168.45.62] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm3540149a91.5.2026.10.29.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:29:22 -0700 (PDT)
Date: Thu, 29 Oct 2026 02:29:22 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
In-Reply-To: <12c35123-2c08-4d3a-b08f-c646b1a7b982@blackwall.org>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
 <12c35123-2c08-4d3a-b08f-c646b1a7b982@blackwall.org>
Message-ID: <179326615954.265212.11556019462202036381@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Nik,

I am not currently using bridge CFM in production. I found these issues while=
 inspecting the code, and I agree that the fixes can target net-next when it =
opens.

Thanks,
Baek Kyu
