Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01A331230
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258192; cv=none; b=U76dg//m07+6/VQ3Gi66XhnX531BgKtW3yNqil2JlIdWWrCBAfGfsJyLLiNI3EpeLUW5O970BqxSulOqTibD1o2uSCpK9HUnAMeSf6Hb7IrYITozccFQ8t6tFL99npoHnHHsP72ppV7/DMpjXqzJnCpNeHm570Elk6BW+Nunup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258192; c=relaxed/simple;
	bh=eqfb9Gzz9lqc50VPMtKGLmCy4FdMWzNDV9Bhj815oU8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lyeI6+NNRwNjlTznyUQffpX0jogf8EFnbjnvGo1w6O7ubAs0mKw+bk0ddIT53qWehcGyRnYat+Bu2ilR/1k9htT9gg6VuhIcD6joVsFbsNIJRB78H10s0KieKqOAuZzz44YRwG8RLzTr+Q7UZAKlcfFxW1SviXcR5qO4RdJS8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJgDAehg; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJgDAehg"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d65190e52fso1389339285a.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776258189; x=1776862989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kma409GvMsddkfqfQhZor4T3arEwdjnxzgLRxyA+Zbc=;
        b=NJgDAehgI8Kxn1oylEYh+fkuyEaUQ07088DuSuWD1oZmMHaFTNZW2w0HTFB4bPxstq
         kDIYmDNsfFyJf1wLjgXz4+zKrD7P6tapR5QnGEwWp7mO8bN0EbBgRYCPQ1YDXTru2HyI
         XMiZ2QHMpJcfjcicLWbMGS0yRoJ4uOdIf0Ez6O+hD1De1Ihbc1QVPDIUMuIseLOqIF41
         biclmsTjxVRl+IS3QUOWNuwT33TRnwWD1YGZT2905/PTlL0vbxnJbU9o413fSfbiwbWP
         L2UCiZP07qONvgbwp+mO4i810hi2/0yRZNMkyw20fkSi7g/IvXmLS+nm9eb/JWH5Iin+
         Yb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258189; x=1776862989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kma409GvMsddkfqfQhZor4T3arEwdjnxzgLRxyA+Zbc=;
        b=fsYV+7Ty2WtwwqMZ/8gANR5IDaSlJ63Pueg7YzhX5uPdUFtAkC329wLftf8t0RFm0I
         2U6LkvWVWwiwpe+KBfmf+qVjgf/r8ciwODk6Xh2KchztcLfWfJpkkBO3Z30mg/DwH/pe
         VbSi0HDxbbHlHJdgWMd7CjfTmBNjzeLMUFc+3dtUa8kodTEH0u5STwDkzcU+cotA2A/n
         3EIsk0QMJoL56bEhGz0Vrpc3+Z6pzaYAixI42QEFu7ZZJ1QyckXhiFnZtdW52hgjBndF
         MRnVX09deRAZWD0LBjFMt24UkLCB2nqUXyrL07auV2aSOgpmY72IP+M5lkmjM989UMC8
         lP6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+10g3gE/P8ACdB1fXC2BS8gVz1bodTwS52wRw+dt7oIO20u+SW0ydrpqd2gU6J9Z9dM0R6zP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0wKe4RFxHZ90fVy1hLFtuihLax9kwChtc0ugFqtJ6tRh01qz
	AeL2+GkvAPAsfDLKvclpETCa4wXTjJ64CLJfZ9d9uysq/TFO+gnJiLvjN7A6j1oCHDPUzdF+a9B
	y/8sAZ2F2Hp1mEw==
X-Received: from qkgg16.prod.google.com ([2002:a05:620a:4e90:b0:8cd:863a:1c50])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2995:b0:8d5:8815:ffae with SMTP id af79cd13be357-8ddcfca7a9emr3153198985a.56.1776258189159;
 Wed, 15 Apr 2026 06:03:09 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:03:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260415130307.1016393-1-edumazet@google.com>
Subject: [PATCH iproute2] ss: force a flush in monitor mode
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Call fflush() from generic_show_sock() in order to work
with pipes and redirects.

After this patch, "ss -E &>log_file" works as expected.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 misc/ss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/ss.c b/misc/ss.c
index 1ea804ad549e23f767633e07efdd9adf1277af18..39b109276ffa83f12d1e1e9f8f2cf58c25737b4b 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -5534,6 +5534,7 @@ static int generic_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	render();
 
+	fflush(stdout);
 	return ret;
 }
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

