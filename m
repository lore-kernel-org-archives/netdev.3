Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D3439328
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386956; cv=none; b=XeCrXX0rQLoJ7j24aAESLdligxwsJwMW1/NHcM9YgrjGFOyQZ4c4Hfqul42MrlOTwaSUW219+kf8Aow1D6az5ZKnr79bNSfJoJcnAn6V364zhaXA1m8l/zAFvbi5Y00kth6bV2FrD8VnCGKLSPNjMJca/eBu/7SpFoMSPO7e/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386956; c=relaxed/simple;
	bh=u/ZlLPGpmJ9soPTzlQec+KW0FcY0DZEckmXLcHjc9wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc5rn1vw1CVQNxu4SpIIsMlcdDTWpdYaHwRNK1rwMt9EZTUhYt0CXrNlAlaV+fjd65vkpvV6197DNS9fM7gs+w5MOevGtE2EkpaortSwDj0HNSi73EzvSqMWwmbg7swLEOFFSLJi1E6a1SqckeJKuGB9Pm+GucTBgnFK+UEmk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoPAwQ6F; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoPAwQ6F"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-cbb92a1213fso733089a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386955; x=1786991755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+CgjfkJ3BqGdDD31dfl8GGagAYvFHOGZHmn5T8XCVl8=;
        b=FoPAwQ6F6Q5win5tViTMVav7TJyPFgNB3KkjY++JRgNnhUy18h7x9oinC33ETXvEmi
         f4o0+guqe+KErcw8OLUiwozWMVW03H3wPxhFt60Rknr1uDp+wPNSgFfOhKKOkiuch1nz
         5Cwy0ybE02G/GNlSZvBzd/ELX7DcUo4fRCB56Gpt6HKnHUn+ZfhM1PsT/7hqwzBaHmxg
         ZEX1lgoyUCPjc22x2hd6n2wUGcZegDiJ5gr2XBvYKgxVBMIweOAlIj11XFHdQ/cUXD7n
         7f8QotX0k58jrEqnkgyDEgUb36x/hhnTQzzLbScdypCJIMzUO2K0VRQCmkX0pSPh5UWX
         tEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386955; x=1786991755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CgjfkJ3BqGdDD31dfl8GGagAYvFHOGZHmn5T8XCVl8=;
        b=CKvwRFHyQijBn5277ZU7Lnn1lkd/mTdX44dG379/YEFZT13YJvXSBiyKOhpy0674LB
         dskug1XMcQ44TvUcy/yAqcx3VzB/wOu3hMt2U0BTSD1IyjaJsOJQs28w62evgYsJAm0U
         uLEezNq9ZRqKMVSDIhCgwRQy1qJdqLJFg+/86Cqd4jIdhn2jNfC+HvOarmSzDYiTWl5w
         T1VoIj4JKVPPXYw0rMmNLIpGsS9zGy1cPSNBCFOWb6f0Qn8QnQirLircG1aecPT3iPIx
         X3CbCKOBehu6XOG6nXNrW2xF3XP4i/2uhUjcY15mtYMAqojeOPytyGG6a6ThRtIVVRyF
         CqZw==
X-Forwarded-Encrypted: i=1; AHgh+RrKVE09+tTThtflMpep//6Q5ahAq51Z+mECCI+ThGMJKZeY6zi2kFXU5Az3WpmfoXzTHuy/pMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzperDWLBkBfRY8GukU1lkC1TbpUicOMbq0QbbF6b064Uc4dd
	mkgo78kKppG6cALafnP0e+YOgXwhchmkESYzEzlaEFkf6RUScofxMgb5
X-Gm-Gg: AR+sD124t0DUppFXOGYTZrcLKyH8IIfl0LI0gwDtS/25h/IrXiZu6KuXk6LzMPozid1
	0Hr13yx/RxtnikWwIErpP7bFR3ID6+sYsKIRBlAHnJczgvroto5mXkQ3+QVOo+8ZVpJzL02/odv
	0Ulszyp0LqwLtFLO+/1HADQhtORr3HT+L+TzWkxlTzwFPfo1EG3r60HLPM92bhp5SrYScz5ht37
	w/i6OLC+3o3Y+6iR44cOdBUbwiDBZKcrX6Sh7sch40cI19UJZAnAReSAfHWW4aCPkMTcSuxt4my
	YPfp0Lg5AkvXF8ceoJSN7pb968rn14G7swwwTjhxw1Ysi3Nnac7QzHy5kwG3IFc/amyvESZu0AS
	azgiS7ayud2SkAgHw99qspOp0tqAWFnQQTMaANS5PYgJbyO10xCSN0QFC06er9Q3hvSQyop9ezS
	PigTEIaZ2+A4p1vnGOABjPQomhPMYG1QxUZG0+fYGCndRnMGaxLnP0VQ==
X-Received: by 2002:a05:6a00:908d:b0:848:8027:cac with SMTP id d2e1a72fcca58-84f9c9b680cmr4243488b3a.23.1786386954840;
        Mon, 10 Aug 2026 11:35:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d32b6sm4370238b3a.13.2026.08.10.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:54 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <anoZ30uUOEvaOj8j@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-4-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
> bpf setup program creates a ksock context and connects the socket.
> Another LSM sleepable bpf program looks up the context and send test
> data. The userspace harness creates a network namespace and a new socket
> on loopback, run the setup and send syscall bpf progs then check that
> the userspace socket received the data from bpf.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
