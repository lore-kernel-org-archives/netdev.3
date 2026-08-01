Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAA31B828
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785563740; cv=none; b=UZ1GqqjdU6mS/61x8xA1QPz5pzVMCNWYUfo91czweAERn80CeMy07nQtSW2uOsLfQ/5/Q7nxyrhqdltFVk+2ySTbuV3hVGYxXPi27FrRvvvS2jl5YOYAGT9CqsMdITYh9yQh30qxlxGrES8iy1SiP1gwHNsYVYjyByKrw1aQQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785563740; c=relaxed/simple;
	bh=ZHdedNPcudEcVol+83qSYMha4eWY9xZ3jg45Y9HOidY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWdYIdaVNKe4kdmunl22xeCcB8RMJYYieCUlhGo0+972+VjuY2s46B/uTiAqIhq1CCylXXzjGJ8FFcw85g2A5JbzJN6Ql8/WNUHsbHqP3IYmA0GCRLlJhxMNjiM9qQPK0FcbP5yyVT2HVXQ5Jj6W0TX8rJEBFPfGQj6gGVcTqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bq0Lksk1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="bq0Lksk1"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1590198a91.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 22:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785563735; x=1786168535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0YoODerQIzEOVN20KJQiVnY06JcnNCgCt2bly7t1Fo=;
        b=bq0Lksk1Lv0zrJjlb4BgOI/7ySE/jGJyriPfZutvDqXQiBzkprJuBByFyJFedLq79I
         AJID9AJf9FOn118dIH6qYNIWqX0xtMS8U7EK2rgHMOOWXk2Mu+Q7RqtitrqGriBSDucL
         cD2XhI+dLpOehAGKLI8z7yU+ygf1KT0Kpa5xrAzhMmGXwuj8XoElt7yWVp1tUE/KILhZ
         ottEQqyo7UD5yZQYKl24m4zeQRlGR6PF+BN20/3+knvO44+jbrVs9Jt2qfHaZn5gGdFq
         nwfwcQoqimYZ5XkTQu2dTZXzw7opAAEjeCv3na8bkuEvdwXXqmSu9D4JExD2pZ2cYJNh
         L+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785563735; x=1786168535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0YoODerQIzEOVN20KJQiVnY06JcnNCgCt2bly7t1Fo=;
        b=jYQSGWpGAkFsL5Uh5AKFzkp/MENEZ1/AZHX8GyS+57H4odCD7Kq79HLUZgiXSETWgm
         72trKlDrNI6yY2xZr487Wcz/O21ORPDKHzFkxP1+fFnNE0lkLhYsVo1EA2TAenhJT5+j
         ysd/zFmbs2W+W7Mz0A4fO+N3KjAG4sGEFR9krspxtF6SpJeS39fWHpZSo8KMdUtXFulD
         LtBeMJ0fEpn9W8I5AogPqFaZzDLsY3sVBT9FnsUDvuKgiOzaCZZqswS5F4rohOq5JNzX
         fMlphBy0w++1QP9VIQZWdR/YEkrmifMf5l5ILBdaZvgocPKk3hRerMMCOKpxZ57b8ez6
         ppHg==
X-Forwarded-Encrypted: i=1; AHgh+RoGC/hKUkJPsOP4x0f7HmwFJtJhQ1WcnV6rO/f7CfAMRI3X+VoC3aWu7F/7Hib0tOCQ+978/u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJF1/Bzr53LrVaJjXxKFhpgjFrztzPjVnTkynk/8wUdQdopuma
	CdJdJAlFwsf57HdzHnrKBRm9ydZ2XopHLP04nsn5ShNCvTELtSo/OF3pHR/TjioOdfA=
X-Gm-Gg: AR+sD10Gch942j3rYeH3Q9xsz5mRTocUlqpATmsrAnb4XcJ+K89WLyTFgpFHi5PBhHA
	ohStIZcXgq32fzAB0jUnY0oN89FLIhImN5y4ab23Gl6yGDX1cbdPJP5Qy6dJNQpm12qBAvvZjXj
	AJrDZWnL8M/hFE+84/DrFId8xL4ZcK+jhxgO+LpDqPFn8EX/fHHvWTpAMZUHyqrOO1t88G7AmlE
	N1LIcQsEIzpaHdqc6S30QnB/3vdO4IQxzJ/UuJF9Ocm3pjMFF5eVi5KUnSOasYThz3Dx4POulpn
	vOb5wsS60fn1o9nF1AfQdv6ITFTGOuxeFgbrXkVfvnSHsfzQGOxuNAMXBDagGp7GEhsv8DOpPgL
	81nrIWPTwFy9a8BRJGjNOU89eQd8KveBQvz7f3yWRYgUBMuwRJsKF1bM4/raCJ41j6bTOKTASao
	uZvKvNDTbFwL+5jQ/igw0kMpI/uzOCGx7k/OL2Hrq/+S22+4r4Y0QfzsrrVdI9nmz0DZUAm8yxK
	B/WKney0xzlekkf11wMi6zmW9iZasT1MYP8NQ8lMOHjoezzkq74Qm0YEjuOhCtchtjamPY/TRSJ
	dE+NFV1bjjIxlOY=
X-Received: by 2002:a05:6a21:9995:b0:3c3:b4e8:5565 with SMTP id adf61e73a8af0-3c92a8f301emr2512911637.61.1785563735027;
        Fri, 31 Jul 2026 22:55:35 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13fab050d8csm16502537c88.0.2026.07.31.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:55:34 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Steen.Hegelund@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	joe@dama.to,
	horatiu.vultur@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH v3 net] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
Date: Sat,  1 Aug 2026 11:25:05 +0530
Message-ID: <20260801055507.47534-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct vcap_rule_internal, keyfields and
actionfields inside vcap_dup_rule() are not freed in some of the error
paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().

Compile tested only. Issue found using a prototype static analysis tool
built on top of the LLVM compiler infrastructure.

Fixes: 610c32b2ce66 ("net: microchip: vcap: Add vcap_get_rule")
Cc: stable@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---

v2->v3:
- Rename the error label to "err_free_rule" to denote the first action
  being undone, as suggested by Jakub Kicinski
- Move the information about compile tested only, and how the issue was
  found to the commit message, as suggested by Jakub Kicinski.

v1->v2:
- Convert the error labels from "err" to "out_err" to avoid confusion
  with the err variable, as suggested by Joe Damato.

Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260727125757.134611-1-nihaal@cse.iitm.ac.in/
Link to v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260728114253.196398-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/microchip/vcap/vcap_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index ff86cde11a32..788c0728d763 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2427,18 +2427,21 @@ struct vcap_rule *vcap_decode_rule(struct vcap_rule_internal *elem)
 
 	err = vcap_read_rule(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err_free_rule;
 
 	err = vcap_decode_keyset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err_free_rule;
 
 	err = vcap_decode_actionset(ri);
 	if (err)
-		return ERR_PTR(err);
+		goto err_free_rule;
 
 out:
 	return &ri->data;
+err_free_rule:
+	vcap_free_rule(&ri->data);
+	return ERR_PTR(err);
 }
 
 struct vcap_rule *vcap_get_rule(struct vcap_control *vctrl, u32 id)
-- 
2.43.0

