Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F64317D
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502780; cv=none; b=pAnvOeaYZ0xxgfTSnZqiz+qjMDXlt64gxEdYI0LBDOiPR/AhLBol2TLvEg4urJ9BM39ZRO2If5BgNvNYYuc0ePTdzKfaLqwgEEOw7z+j7nUM0FhyVc2F+TZAze7uAeE62YsjyvQYX8rPZvwfJYP+reFT/4iSNOuSUSL5Nf9P7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502780; c=relaxed/simple;
	bh=XyVRHmq3ZBJqtfX1mx701c7pNEJxwUU7t8igX9Sjq4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRsBYMN0NYYzrui6+iil1/DuVX+oTXbjhV2QNIbZHfbsJloN0O/Pkh80J3yK2Bl/DCTYgLcFZYdVkIdEOI9a5sE59BhDgwby1L8xla58I8yKS9vUYeZLVQpg0dYcst9RFsa6uHTPjdAqaKZY4ssywgUw1Plf5VcpjTwa012eJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2soXUTo4; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2soXUTo4"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be27fa54feso4140477eec.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773502778; x=1774107578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ/kEFe5EtaJoItlhc0KGn/LPzGM7ff2rqYzEoAICNQ=;
        b=2soXUTo42PdWpyVqCzcOCQ/sj3OaHbAOybvs5Vf88NJzXdWo6ibwMIlZxOi5eSkDCe
         XlNV9dOnIHSQmGAQMvhDs6a+NhbPkXuxvLE+HxmznT4hRaVo4/KuOwbT8xBuln5/g2me
         aM47NBupupD5HGiIt6ErGMJvu1hqCjma6/LervtGnduJeNa5PeldET3vGf+kICTGC69g
         XWjNu9IzbvebmWP13NIVQGrranBXFei/UWmcENIuTMGx+cxsBTudQmq95wgPwfulzrMh
         ktM8uzLSBuGMp9XnbokYbDpvrODAkUW459N+pS7oikmj/+s96OYK97pz9kKInFL+RFTh
         QOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773502778; x=1774107578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQ/kEFe5EtaJoItlhc0KGn/LPzGM7ff2rqYzEoAICNQ=;
        b=fre6S/9Ws8YEFum1Yd/+jYhDFUkD/Ow6BoHTHeVVr2lbJcCfnNNSmydrp+n2XTHYNh
         gsOXxpaHWduxI3325t7wcxYIs2CxWOt6upJDdXDrmZ6e6KXXiUGZVxOCHSJTSYrWGy2i
         2UrqNu6d16nYAUd034rZLUDt6QaT+lIxzidYM8lTi2JjlzSSOLlg39bRGaN/UJsRWkOF
         T/RrraN+T0v5CcnQ9I/aWFGFOtTQESW/mePR5Yt2xmS4LqqkEJK0y/vrD1Q+lzEpb5/q
         Xcemut4sOleLDg1+WjRNjdxnE6SLmUFp5TN/HbXDyP2LwwHKr1WYeA/hHqLgE/TcJ0DV
         hO+Q==
X-Gm-Message-State: AOJu0YwhH7snAbqAhiO0FSftwgtsTEHNvl3ZMKJtn/jzyU2cx37BH/zr
	o5DW4q54i8LJj/orOuDOTDAHBkWiJQ1meOSpmAdR0TtwJbtoVVoOWdBP8YzdlwR3BLHSPSQDI1W
	Fibit
X-Gm-Gg: ATEYQzykiGvue6F0M2YD6VQSt5m0RcVeYtjcvMl5YyQj9+h+n7Bwcht68aaayugz0kj
	GvgTeyRYC0//PlBDm4SzZcLGUWVg9spZbj6yCLfLmp1qmGuncmztuIM2e8yRzy9SSpJkz4PU8GT
	WVfj3MChGYkVu7ALlwMo1bk8sjHCsEqASjp7qiW7U2sKOfYjcrKhSU6ZhKFtitJegJgE7vK6Shk
	YAkQ1pDslcT8ZDiFXCGtQFPcxqGVoeWaD9osnFkU0MeeQHLGYu37ateyNV6V66Uh/XoTRbM1sb0
	QdQJBpWPx7TJmxU73qwDEJsX02vbmVjfld3Bz+5fRH4+yD/6SRIugnjzZHNDSwJCuq+xrxstZr8
	EWAjafmqCHih05Um8wKy2OZ/cbtotw+gSIPF4Bpx5vjj8AzAOh0247Ukf6Kf6TKGxkEJJ9Nk0+6
	kUmi4WEiwtL4Nxz7nkLJCZjGp1J8WBccPnSXs=
X-Received: by 2002:a05:7301:290e:b0:2be:79a:69ef with SMTP id 5a478bee46e88-2bea54eed35mr3357681eec.20.1773502778223;
        Sat, 14 Mar 2026 08:39:38 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a1122sm7003198eec.1.2026.03.14.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 08:39:38 -0700 (PDT)
Date: Sat, 14 Mar 2026 08:39:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] netem: fixes, cleanup, and selftest
Message-ID: <20260314083933.060c1449@phoenix.local>
In-Reply-To: <20260314070902.4025c388@kernel.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
	<20260314070902.4025c388@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 07:09:02 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 13 Mar 2026 14:15:00 -0700 Stephen Hemminger wrote:
> > The netem packet scheduler is widely used for network emulation but
> > has not gotten enough of my attention lately.  
> 
> There's a few tests in tdcs which need adjusting:
> 
> # not ok 363 d34d - NETEM test qdisc duplication restriction in qdisc tree in netem_change root
> # Command exited with 0, expected 2
> # 
> # not ok 364 b33f - NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root
> # Command exited with 0, expected 2
> # 
> # not ok 365 cafe - NETEM test qdisc duplication restriction in qdisc tree
> # Command exited with 0, expected 2
> # 
> # not ok 366 1337 - NETEM test qdisc duplication restriction in qdisc tree across branches
> # Command exited with 0, expected 2

That make sense.

If you run the new test on unpatched kernel expect three failures.
$ sudo ./netem.sh 
    PASS: basic netem delay
    PASS: basic netem duplicate 50%
    PASS: basic netem loss 30%
    PASS: basic netem corrupt 10%
    PASS: basic netem reorder 25% gap 5
    PASS: netem with pfifo child qdisc
    PASS: HTB root, two netem leaves (no dup)
# tc rejected multi-netem tree (check_netem_in_tree bug)
    FAIL: HTB root, one netem with dup, one without
    PASS: HFSC root, netem child (CVE-2025-37890 topology)
    PASS: HFSC root, netem child with duplicate
    PASS: HFSC root, two classes each with netem
    PASS: netem with TBF child (non-work-conserving)
    PASS: HTB -> netem -> TBF chain
    PASS: netem with SFQ child qdisc
    PASS: netem duplicate 100% (stress)
    PASS: netem duplicate 100% with zero delay
    PASS: netem all impairments simultaneously
    PASS: rapid qdisc add/change/delete cycling
    PASS: netem limit 1 with duplication
    PASS: netem slot configuration
    PASS: netem rate limiting
# tc rejected multi-netem dup tree (check_netem_in_tree bug)
    FAIL: HTB root, two netem leaves both duplicating
# nested netem rejected by kernel (check_netem_in_tree bug)
    FAIL: nested netem (netem inside netem child)

Summary: 20 pass, 3 fail, 0 skip
