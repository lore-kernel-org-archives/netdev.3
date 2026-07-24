Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C43B1034
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924918; cv=none; b=u1/OsECdMFLKp9Ot8O1igui36WOK3442dzqJcXbgNF6qX90xq0F97N8o9NC46YcXHg7EatX5Cah9YwYgtVJs9yF3gMGGEoEjBAAh7qJmH2Dvrqonu+1CwBG0kUU3uFJqbXnphlBNvH15Kbw77v+KMkty9BUtnJzXbATeha9N1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924918; c=relaxed/simple;
	bh=bxgR+lFRZlwR7Hj9/LlFcWh3fU3zhLg1LK3gfBstOKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuGeHdh/4KL81qClNDxDFe01NjCIOGRV6ThDC5eaO6JObW84YMFlm7FXffWHHweUkDhgsJCyJPVUro1PVABFdU6CTo5vUqBb1r3F7bvnGzj12Uryfwrt8inAwsrN6vspUmOK79SW7Ypq9ACFbJks0n4hCe+C+kwAWMjORB1gWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXkBQ5CB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXkBQ5CB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c160d8760e0so11691066b.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784924915; x=1785529715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0YscGCWmrwCJqFy/OLqZ4anRHWVPww7PCVDd93wLEZs=;
        b=kXkBQ5CBKKIQQ677BuHZ48idVtrj/fDu0nvDu5+HrmzV65anOK/DdSW0jKKsCkEVEQ
         B1ACaPosIKSZLfrI8u7xYVFsEJmmY9C24jldWPufY4nQiJQpbQgbCbBet8fe5XIx88Tq
         0Tn/aQiDyjuUZb/lO9p0NOVudpfovJr3NgQ/LUODde402seZbI2H6CpoV1NGpYLyni/W
         rViM67PF77q2whd5e7RWPzhbsxbQ6V3C+5b++VlLSh2vrcjqYsWr6PVet1zWL6ZMe8IH
         CAeHIXzZOfuYZTY3sbVrbgi+qh8mZ8qf8dMlvu2W4YYZuj51yEwCA4agEeRheTv0Fum/
         bHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924915; x=1785529715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0YscGCWmrwCJqFy/OLqZ4anRHWVPww7PCVDd93wLEZs=;
        b=nI4BRNS1gBAaQkxnMJdBPTgUcpWrcv2NCZJ3vvWwY3/imXSw512KdD+GsmTa4kNQJN
         NuIAySh/JQCNxvmj1vXff4fefdA8aGmrIy4fmxTj+FBAuO2AIaj+8oDBWsyrGKKO7fsA
         GMaUMc6S+eSadyGZlLQGKdONI58367UR/t6rc2sCVk1WhPGB1grD1jFoR+RVP5ppPlTL
         nvnyM3mTWBsdTJfzdmV566baMjhOyCvRltTtcTJ20KDXMnpbiDCbfUC3eKPardyBd0yo
         RnJ+snlDd3vTonmYKKeakcl7WLpIu7sOP4mNUvhIQ5kWhtoKRXDeVqnHOlX0+giikBXU
         ZkPg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7rNh3XUjaY3p4KkueP9dc2CRqLFsXg1gZFhMtlF3FcJHTPEK67qM1awgosTjRLuPSWsSKUo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBF3AArBirFY+s4FNPeh4jmoOjZ+ArBgkg/kHOrQ+RBCBWCDi+
	oeD+uXOkaYi8zQZnGIaC8n+oAkc8c876u9pHiz7yINSIBft6SDs+ILNt
X-Gm-Gg: AR+sD111cyLGDxlngenUxWDZnyTmjH/EMaepBhz3p2//YLVC8QI1+RyDGeavO32Ntwj
	m5syivuqHMujm8xaI1TtGn622WZ81uHdgZciMFzdN9yxwVi2L6aQMNQNE1OGJKdD8x9yjJ+bn4C
	J1AXGySfN0vJpz6pvW1kNfp1FyUxnssCK3CvhYx4vm6N6qrHssenE6mBJv4y5NIq/lANxmXBjc9
	OhhRTVw8Nx8n/czUqu6kcWL76z4eluL74si5H8Smix4dUId4YE/4K997HEq6RWHGUOZH/CD4pq4
	13982xFtSGDXLFcnAzR9j9c5arnXWbwC99igL8zSoH89hurx9TYqcYVygmcxCgU/QyvOOiZ55s8
	gJBVr9sIwO2iZPiabvuczYNwDswn72nAWZTuWJHxAuyscaHQXlHIKPJ9hoJuyvbFTaKdJ4qfcM4
	RhZ6WCwci2ca3SW5voeJbDdQ==
X-Received: by 2002:a17:906:eecd:b0:c16:7b5e:5143 with SMTP id a640c23a62f3a-c1c6e5dd199mr158801866b.1.1784924914435;
        Fri, 24 Jul 2026 13:28:34 -0700 (PDT)
Received: from sheldie-RC14UD.. ([109.69.61.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32eb8036sm376967366b.45.2026.07.24.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:28:33 -0700 (PDT)
From: Nikolay Ivchenko <nivchenko.dev@gmail.com>
To: hdanton@sina.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in unmap_region
Date: Fri, 24 Jul 2026 23:27:53 +0300
Message-ID: <20260724202753.248227-1-nivchenko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722125604.664-1-hdanton@sina.com>
References: <20260722125604.664-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A known issue, feel free to grep broken in the 2025 report [1].
>
> [1] Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in inet_rtm_newaddr (2)
> https://lore.kernel.org/lkml/CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com/

Thanks for the link, Hillf. I read through that thread and also looked at
several other open syzbot reports with "stall" in the subject line that have
replies from other developers:

  - https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
  - https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
  - https://syzkaller.appspot.com/bug?extid=c28b5fee66fd3b7f766e
  - https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce
  - https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
  - https://syzkaller.appspot.com/bug?extid=51cd74c5dfeafd65e488
  - https://syzkaller.appspot.com/bug?extid=5b4f4f81240931b16844
  - https://syzkaller.appspot.com/bug?extid=4507914ec56d21bb39ed
  - https://syzkaller.appspot.com/bug?extid=0635dc2e2c3c21a6aa04

In the reports similar to this one, all the attached reproducers configure
taprio with very small timer intervals. I haven't gone through all the
comments and proposed patches in those other reports yet, but I'm looking
into them now.

> How many hours were spent?
>
> And my 2cents suggestion sounds like sit back with netflix on.

I would gladly do that, but it really bothers me that there's a single
issue generating a flood of different bug reports on syzbot. As you
rightly pointed out - how many hours have already been spent investigating
them, and how many more will be wasted?

From what I can tell so far, this remains unfixed simply because no one
has fixed it yet, correct? Please correct me if I'm wrong and missed
other discussions on this topic. If that's the case, I'll try to propose
some solutions for this issue.

Best regards,
Nikolay Ivchenko
