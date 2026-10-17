Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1B21CC59
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200643; cv=none; b=j/qNx6p0vQKVJevLgAibPzi/VWqfpQYZnFffa0Q20DVTfG5ySAfe8EH6uNlJB/jFDK1XYMRkjt1ywPlb8q4AjTucGiREimqR+RTmsrJ8YCXRqb4S0F4NvJUeBKAf3ZivaQJmi8qVY3RytPV/mjx/RBSeT32taugotmMvT4ibLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200643; c=relaxed/simple;
	bh=1vipa/BUWLt7FxSSWIAQxQD1mC5GvojWAIA5QQzic0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUJSBw9CdpDQf8n9rEZ0i20rhooY8KlgfCVhJiF6V4XXLwEM2TTNg+c7azI3aSyPp/h5IQFoIF3HFmm8Srk5yQ6MHsYKf6Z9/I2pnbJs7UiM/iBrMNJr4U8qdVTyEgROPQ2PsgyJGA0z0BGuDi8KZ9xDIsng38LgXb52bacDyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THQ80jbx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THQ80jbx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso352075a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200641; x=1792805441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=THQ80jbxmrWQUGABHabjqzQfQUYGVWZBO6zpHYB2QHSMA7TStkIWAAFP8G2gS6JCQX
         x9Y/u/HsHNHNSDoOqiD8UJw1fhU4xEpdvHKIjpsBHofYeRHHOIARCT/2Z2T3oReATIj0
         +kG4/wo0xp440UnVwR7nlWGv7exHcRP4VHrANUr5EU8gslbdiccVUCn6TkEeL2xW593g
         zryTGDxe8rpwSfXDfb0Fuj+w8JalrH9cjM6rHnMjC9LAyFplhGyepRzBjf4mzlf+nHmR
         kGhqG6D0KEh6MllYo5IqudwCBQ4arZx7Nk+HiQ8mvr31qkcfPXs1pzzxp9B4MfhuLVbi
         FR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200641; x=1792805441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=CGr0dmLDF2E39gqiLo6VdEkAEzo/aQW2zZrviBOwXlri1EzlVedfV4ep+AzDYr36rh
         ZbZ488D8m5VfRQNXNcFPZ4Jzcp3Q8z8zQiL5UMrjg9D/cwsc5n4TzAtscNu2AOEXX+cR
         cNQSmmKZg+F6FIa11cGDHeg1CEZeqPr1gEDeU5Fb/HyTXtKOM98vOq4UY6ZqyipTqax6
         Eg6GnHYV4yhFKEHof5LfdB/FB4uDhSlTDZ7hP64H1HcHfJZMEfrqolBfn8UMN7ln0o8/
         T0qXXWtEnBAlF5TTy9NuktJHFtGORLtneAiPFyOU6hXBReOG6NezXTODHQD1zEHCiFgx
         g2LQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlpXeuiW/14K7CDqcFt5YcogrCMxevDqTt8vssjDk1g6A34Qj3ExuPN819enZvEYS/E9n+Y+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeEeAxaIoA2Pnm9TGPjzzRmShU/PWxjRQsR5ANHE6ro20Ee0Rm
	yiWNDuX85Fb4MSszU5zdbpqJIOIHSp7gQtsUwHUZuay8QQPha1mF6TYf
X-Gm-Gg: AYBFou3U2cqXsI1ouy19Y0zINfsk26PuLjZaOJQw+4WCMynxZHA+GBqoXseNs24q/ss
	CKmOXss07pD9JIXHRSsI0LOQdkNsC2MgipiXvVK9EahqPnc5Afxnz8HKqa33coSy5xgeyMJ4H/r
	Ku8FDApKITiEM8MVNMLmSCn3F+D95kiMm5QYyrBJ0KpRJHk56vYRbFnBQyRsXruRjuEzm18rduV
	Kjk4Of1bI4dU+mDZdb8B6iFWIjQUJJGEQR4ZMON7TEJdrgXWRZvdBXcAfyCPP/nUfDKERo4a3Km
	1+dz5p5HErAruTcZFTo1hygUTQA9nKajxHAIGDtdN/Zc7Qxh9eF67qXLJJyLTbFFbH0p2qQEAy7
	TCFqrQTyMQwjqHb+Rj7ZuktoebW+XrJBnyj7TJFAZG2NR7ilHqo9UTTTvbFQEjduQ0psbDEWTEy
	Ukb63/jWIDDgwbUm083GbwzynbOUkD2txd5GD0rMTW6ooXOfAj72HRxqw41QvHU1xBqU5bsTzvP
	AhubQ/H6IEy64ZsRpP0C3UF9uLP8oaNxgRcAB0SCaEJIxpPQIbqc1CaW0LM4rwuqFiqnejGVjq6
	2HwFMFcvUAmoexy+O19oWh5ixIUf3pQSsQRRpfDEtvs=
X-Received: by 2002:a17:90b:264a:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3acef578121mr1187337a91.61.1792200640519;
        Fri, 16 Oct 2026 18:30:40 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1e1esm6264686a91.1.2026.10.16.18.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:30:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 25/38] bpf: Don't take an extension for an iterator program
Date: Sat, 17 Oct 2026 01:24:38 +0000
Message-ID: <20261017012451.364800-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

An extension inherits the expected_attach_type of the program it extends.
If that is BPF_TRACE_ITER, check_attach_btf_id() hands the extension to
bpf_iter_prog_supported(), which goes by the name of the attach function.
For an extension that is the name of the subprogram it replaces, so the
load fails with -EINVAL, unless that subprogram is called like the function
of a target, bpf_iter_bpf_map_elem for example.

Then the extension gets the context of that target.  If the subprogram
has as many arguments, it can use the key and the value as buffers, but
how far it reaches is noted in the extension, where the test of the
iterator link does not look: it reads and writes behind the elements of
the map.  And the id of the subprogram in the BTF of the program is cached
as the id of the target, so that programs of that target which are loaded
already cannot be attached.

Refuse all extensions here.

Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 4668c1696a08..5fd376bd210b 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -351,6 +351,13 @@ int bpf_iter_prog_supported(struct bpf_prog *prog)
 	const char *prefix = BPF_ITER_FUNC_PREFIX;
 	int prefix_len = strlen(prefix);
 
+	/*
+	 * The attach function of an extension is a subprogram of the iterator
+	 * program that it extends, whatever its name is.
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		return -EINVAL;
+
 	if (strncmp(attach_fname, prefix, prefix_len))
 		return -EINVAL;
 
-- 
2.55.0

