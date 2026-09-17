Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB304D0CED
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642668; cv=none; b=R/YQOoz4q4UhIEBkS3C3x6is4FPYeEzds56rJAmqiDUuaiKpFYVK33boaYi0g4p9DgAWZHE3aADZmVUO9CIfjkDuP/y+wrZxO9TsaYaJRX7f/ed2qO3P+0vCrGeq47dVX+AblZ9K/3ctL6tYdpWFSJJlBoxbMZl2T0OQqAW1Rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642668; c=relaxed/simple;
	bh=vTuVMsxqVutppf9Qg6jrf/J6HZlhLrGgOLRrHMSXI8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3w782Qd4fcvrUm9LBYAxaU4FOZZ2oZer8FLJZmndH+wu0rloX8G/O5SlRZgDrn5zwBmd2oXfW00vb+wscSL5q9aw10vI1cyeVGfCutWk1oR0dWgis6ZxoaoSuqmLEIVABo5Q1Yg6ucFF3IEQ53mTA2lPd0eidos/+ssJ+2jm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DySk5lVy; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DySk5lVy"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ec506so3901281cf.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789642662; x=1790247462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyDul+0eckncKMhOqV1jOasAHdl54wm6FQkY84Oez6A=;
        b=DySk5lVyB3dXnhx7CElcpWpLwXcVSLKwN9Owne4yOgSYCYAvlcMwP2l0JOmFw1nP/O
         egXkgbyxwJS62UhBBJJB8txX8YOCVV0MGEYmBQywTGbaEDXwqtCwTnRVPlAYVxfkQkNT
         TfeJF6iw20l/Q8tBhad7AwivzXLYXQCw1/IHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642662; x=1790247462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PyDul+0eckncKMhOqV1jOasAHdl54wm6FQkY84Oez6A=;
        b=asSZp+1IakAU0tipWZ+qFQyZaaVYHYyErkDHe7gJCQHcKL/KyGGWaI/ZFHkv/v7Xlt
         quP56JSTAJaWh6blq+xekn2XeIdNXwNrJFCsLpXUDaro/02FRXd6OkFrAOy8vldd4LGx
         J2pdmsLIsiqXtPoDSZG7zm14MX6KCj6xENXWMMITfjE3xVMXHOQGX1q5vm0QR246aHT5
         gOEDKcfBA0rYNACMYAk6NnWGEfQWBUKzPvWKWHwWjSf9tnmZxEsT2jlqTC7CLZjgB3Ve
         3KKo1qYNn21R66+ZAFLyxTKAeVg8t8vH0DqvepB6PA/Qw6wHuIwMZkOxjDc29ZVK8q4r
         xykg==
X-Gm-Message-State: AFuF++mrl1LR9fioSqRB8TVTTk8rZ7PF/W3UYVlAzRqCIbiw1ieXA2Je
	AfazcieEGYn7T1RH06Rd1lVJbnNKYWjZHd3spj+iuDHSKTcuK7caoawtP43WHb22kMPY8Qukno/
	Gi0mdvA==
X-Gm-Gg: AYBFou2OtMIym/hkLy1IFbN3T6NC640WMYLuGlEbdldnfGW1I6Y9nt3vBt1x4PV8TIt
	U6Gajpq/Ivop7bu+IkEaDH53Lf9cMQumQJYpEJ+LwGkZ/YTAmLnGJTIGXN+b5F1CwbeyWtX6UIx
	U1dbSyQVWMxII7xdI52+bqrOt7QdHJ0ZIQkoVsYkgIhLz0mRbYcSJa1Kf/to2BzdvW6TBg6P7MR
	Y6E4gAKkYX/tEyjGhSIgogy4xLpQw8pE0INnZmBaveR+a5+b1XvR1+zB4lB4a5THnT3CVNCGGOD
	J00YN5dreQtVPAF1FiYA5wReEY3OVZSn2EUYHLka0Gpb7rSE9i5g6kG9TFM+zDFyM5TmVhKdwQG
	GBgTYJcoijmwCI0LW9GPxKSfARm14DdNoNl58PyZ/QMGgqpjCg0WnsI5vT88IBtRhHCmNw2chtv
	LBSaTUk0396rsIQvS45W7a/3QTmnlfPnist4XBso9o3vKEcWbxSnl9jfIZpuwm3VluotJ0jyhCi
	IcFqqZUdocQSZEfHbJQNr6WHEsG2PFnl0YtUbcaG/fGw/IQNgLcVDYzoB7z
X-Received: by 2002:ac8:5947:0:b0:52d:ca81:e5b2 with SMTP id d75a77b69052e-5327ed7fab4mr111865091cf.5.1789642662312;
        Thu, 17 Sep 2026 03:57:42 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620c2ffbsm46914451cf.27.2026.09.17.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:57:41 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net v3 2/2] selftests: tc-testing: add a lateral-drift hfsc classify-walk test
Date: Thu, 17 Sep 2026 06:57:33 -0400
Message-Id: <QDISC-CTUU.v3.20260916184908@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
References: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The classify-loop fix bounds a walk's non-descending hops, so the guard
must not misfire on a legal walk that reaches its leaf through a
level-drift lateral chain. Add a case that builds exactly that chain and
asserts traffic still reaches the chain's own leaf.

A lateral hop can only exist because a bind was legal when it was made
and a later class add raised the target's level, so the setup binds each
hop while the target is still a leaf and only then deepens it: bind
1:1 -> 1:2 while 1:2 is a leaf, add 1:20 under 1:2, add 1:3 and bind
1:2 -> 1:3 while 1:3 is a leaf, then add 1:30 and 1:31 under 1:3 and
bind 1:3 -> 1:31. The walk root -> 1:1 -> 1:2 -> 1:3 -> 1:31 then takes
two lateral hops and must reach leaf 1:31.

The default class is 1:30, distinct from the asserted leaf, and the
verify pattern is anchored to the 1:31 stats line, so neither a
fall-through to the default nor a nonzero count on another class can
satisfy the check. On the patched kernel the test passes; with the bound
forced to zero the walk falls to the default and 1:31 stays idle, so the
test fails.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3:
   -  Build the lateral chain by binding each hop while its target is
      still a leaf and deepening afterwards, instead of deepening first
      (Sashiko: nipa, gemini)
   -  Make the default class 1:30 distinct from the asserted leaf 1:31
      and anchor the verify pattern to the 1:31 stats line. (Sashiko:
      nipa)
   -  Drop the trailing "sleep 1" so ping's exit status is the one
      checked and no command escapes the test netns. (Sashiko: nipa)
v2:
   -  First version of the lateral-drift regression test.
---
 .../tc-testing/tc-tests/qdiscs/hfsc.json      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
index c98c339424d4..4f6bbb8b57f9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
@@ -169,5 +169,39 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "8c39",
+        "name": "HFSC classify walk still reaches leaf after lateral drift",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "ip link set lo up",
+            "$TC qdisc add dev lo handle 1: root hfsc default 30",
+            "$TC class add dev lo parent 1: classid 1:1 hfsc rt m2 100kbit",
+            "$TC class add dev lo parent 1:1 classid 1:10 hfsc rt m2 50kbit",
+            "$TC class add dev lo parent 1: classid 1:2 hfsc rt m2 100kbit",
+            "$TC filter add dev lo parent 1: protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:1",
+            "$TC filter add dev lo parent 1:1 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:2",
+            "$TC class add dev lo parent 1:2 classid 1:20 hfsc rt m2 10kbit",
+            "$TC class add dev lo parent 1: classid 1:3 hfsc rt m2 100kbit",
+            "$TC filter add dev lo parent 1:2 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:3",
+            "$TC class add dev lo parent 1:3 classid 1:30 hfsc rt m2 10kbit",
+            "$TC class add dev lo parent 1:3 classid 1:31 hfsc rt m2 100kbit",
+            "$TC filter add dev lo parent 1:3 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:31"
+        ],
+        "cmdUnderTest": "ping -n -c 10 -W 1 127.0.0.1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev lo",
+        "matchPattern": "class hfsc 1:31 parent 1:3 rt[^\\n]*\\n Sent [0-9]+ bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev lo handle 1: root"
+        ]
     }
 ]
-- 
2.43.0

