Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057495;
	b=f/z9NSCvOF5EPBkWGfJsQFx8iCKWADGSKFJwcknU/tXWM0XclI78huWdvq3zMgen5MBB
	 jJTuen5SuacL6e+p19dcy5Iu2mCWPS6yzy5oge8qQzba4zW4i6z5tcQhVc9Uo1v3fXi6p
	 WVANp4e4KNG2ZysdFTWjLYiV8poyy9J/+W5nkuTR3nV4BVgC+ZqnyRhf/U8lf0gv6l9Wf
	 DLut1ns2ZqT2YfFOsWnhu/kV0aU6fId7b8D1R/NRiuGwWp2Wj8jLVeo4v3/xIngSaD0E5
	 C1WYR7vgwg/MMjMaGbQXKzYrxrFalp6KG6TvFhq5GdjcXJ57j+8qevjuMFsql3t6B1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
	b=AEYkstsioSIzWVAZPBJ8XpmL7N64ypu8fkytnkSLqv9r99St4ehFvnka8rEgSR18QmJ3
	 SoQURpMPD94IxJ56mscj3UPNJVv9hHhZRnXykhJAaSGuOuurJmrKvYu02MC0YYO3ATC30
	 yioTHA/p0uWwM4aPLnzxue9KjJYv0lJAd9yceNoC0nWNfTCss18NbBBM8WLZhiQPqS+WR
	 ju1aJasV73a0gqmB+KRygYq1IntQHyrEePQm8ootdrqedKAM63UIH+786n/mfdPiVzqe6
	 8XXHz6bNO1Anyde82hLjgvT1EGz6x4YYXUzdmViiS2pIL5yzALTI7bYLe6vcC/bKVgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="cOI/FSWY";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059A606A328
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E059A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cOI/FSWY
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so2621330a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057494; x=1793662294; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=cOI/FSWYuZ9uc4gOXFR6cODAhxfNl6YSVKkc09pTcBfcrEXfJFGza1/6vbnz79ZTNq
         zP7nQkQ4dSFo4mJF5spxHEW8N41bTbFboZmGkyJ83g4EkPU0LjRX9tQOPKtV8h5rWhDy
         efJAQFHcAAQh20lB/pC94nJY0Nf+zdtUCT7I8o2LbjitgGfv7VatsG04kfhoQMvruKw2
         B/jGLBNW2eK7hebxC20mG3rjrmCDXDA22kY09T83qLDk6uDjxDMhyY14SA4zcjYGeftL
         M98ll4rF8ZO8+bPaOrnemWmr237eiCw8i6iE3nelzsKIpA16kemuh1G6DQaGTwPB5Wl8
         9Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057494; x=1793662294;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=GD2Z1qxQDqDgbITBqCzIIaJ36+LeUNFglF2Fzgq5hCX/VWEnjXOOLg4ivGVnrbyvvd
         To1rkZcCqz6nUBiI+lLYbQ3DxdqEd6feOZfvuzCHUS+cdI8nPNZ3V/npixIQ+7/LHqb+
         7hP5hUoVF1zQRxxmzbTAYzF3XRe+06BgTRIsd4h/jqMrYHMkqH1Xqee9bxV4Z+tr1obT
         Mba1gM2JfJaMb+pLyerlybBhrGbe854RXMXQgipeM4z/epJ3yOccchTiCZaPJ5Yf+T9r
         dy2P/jdvIcTdfrvLhAwv0EVdIedJhwtNCPhGgCSmyYImXGyx1xZdXTGVhdO9xuN1pZzj
         aG5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxSfNr9t/ozm2CXttTGROrJqazRNGV3hcTNwWGpaJZbN8JKNYfDon6HRsDKdaj2A73QZsGyW0Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpjvGQQ6WFZPIRHXrwgCpHKKk16WC2107twyy/Bbo7c0KEqxct
	EmqvnczSYLI2wsHKet12xxpLuz5zdRhVjNuaaIA4Mqz98+t12hB8B53z
X-Gm-Gg: AYBFou1jEmlkaxc9XJSI8r26tUJIFFN2VcKa66F97kPtWTE7TsHzwK850lP0sE63354
	Sm6ekq8EH33kQRJjruF1HqKrrG5gCcssN0mqQANLqD/nChN0U83URD/oEt76N0S96g8s9i/K+IB
	uSbecvU5SKpnrn9T8nZONrbXheyNCg0etnVv+9l77pgK7bxd340kTfQ8+JifnVOgfILpdfe/IRs
	SMXVEKYvS83RL7UsNirK92Y52v5afJgqEh0Tegx2dx6VcmMesCWCzM7i6MIgfhnBZh5U1o2E67w
	pFYLRI3dxYtSp43wwNw4wK7wQuri9RriJzhSZfOkK52g+Qv5J3draBJBo12uGrqvp675mK/IhIP
	NhwDB0JvzNEoPKTYbA2yfJLKj+1fFVOXenCLuOUo0w1sK/ais0zM/fFuYL7I+FlzaRWm6M0nEVY
	hr202vICaxc0L0W2jGvoRKO4BwWvQLYGqtbFEwMtE481FOBKOQL0TSBwPjEjg2/ugEGOuqh/qZ6
	31IaYv6iy2sfN2pgMOwd3hn8SuGDb8QiJ9LdBrsox4tleHghk1mCopfkEN0dSffpoxMwqZDUpvf
	u2eNM5k5WG2ZhUO6zanHfkEKH47yWPbNGfXdnKqzeOHJS25Y61TACBLEZzI0rrwHazYAQa1/iQ/
	HlAuOW2s=
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ade9b2ee97mr7287988a91.1.1793057494026;
        Mon, 26 Oct 2026 16:31:34 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba38910sm6631220a91.1.2026.10.26.16.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:31:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:31:32 +0000
Message-Id: <DMF5U0PAK4HE.2QQ66SZMEMQLA@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Paul Moore" <paul@paul-moore.com>,
 <netdev@vger.kernel.org>, <stable@kernel.org>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Mon, Oct 26, 2026 at 02:57 AM Christian Brauner <brauner@kernel.org> wrote:
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

Why not the whole series?
Otherwise 7.4 will be the only release where namespace_init sees
ns_id == 0 and bpf progs that key by it will have to deal with that.
Also the test for patch 1 is in patch 8 and it needs patch 5.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
