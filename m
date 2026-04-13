Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0771346FAA
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100310; cv=none; b=TmnFkuXG0WipijVTAo1VuIR8e52Xue1pmncThU4IyLKSPRAg5e9zwECT1U17204g2zu2rpsuXE71L004slsc8/Tr8USFTHF4rbojr/ng+YB2xb0CoUlIpdeYJyoXeXYgnlVxWxj342DwqT4fv4njpG42j6OWDhYkn5PQ5mRaHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100310; c=relaxed/simple;
	bh=ErwOnT0JgTTw7vhCQZp+f8jltSpFdP+zGg2SkB2ZJU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef/uzHJEMU8YyLf4g/SCNsjyB/KCKG/z45bByiegCB3YltB5Kv+ytIZwpWlFvy7NEy/+t+gQCO+u3aJuTgmB7LsjaAS+c2/gTBIU4XmhfR0s0ffnHhYSsapWqaKsxNX3qEDpNvEKDRk8s2vJzT+YBl3PQS+xw+pj9Faqf/yxUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3qSVrAj; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3qSVrAj"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-464bba3a9easo2317991b6e.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100308; x=1776705108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi026evQFCdtftLRIl+IFDB1TLnlqPPKmYddAHJGBWk=;
        b=E3qSVrAj2wLFH3NsY6AnEL82io4DEAGHKIIoq9HBRLp0UbNA5TU8OVP6kQNePw46Ha
         CPbuu4AuuRmYMeHyRYob5vtPleGi2pMhHdpiFYeoVAOGUVJP7LBTp42B9dRiVCF80zkt
         /9ilBDmyJ2A45E/8xS4ttUTEbOjX4JVzJ+RcN7Knymu64W/co44K8XLcJysIWgh4JzjS
         ipIqfoBvOAKmRZ812MioJ7WRsfYrSxSY9ZBXInx2OlTKs0tJ+cXsPbp+e1XXxOa7Prle
         v86WoWI1UzYowP+BJpY4RfRuL/zJFk+rzGpbk1FsP+4xz6GNDmx+kWOfutHvswSzlfII
         2cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100308; x=1776705108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hi026evQFCdtftLRIl+IFDB1TLnlqPPKmYddAHJGBWk=;
        b=scFR6M6hTRcX+GNHGCu0rbzvfwQOTSBt/KqacnnDHvUAPEfFDKZIf/iMPFG+rMlGfx
         58ky6p8xb44hciGakmmYSx0GhBwHnrmthvonPj0pUqMf41YYTYsK3lxgprjwlbv4BWnD
         eYyoiexKkwBI97z1vvglYznwjbWsPGq5wkYaDpSswdBJXzAbrCs5upRPfv7QpWz6LtzK
         HQD43SWRw4u9HJhthceKFltN31f1+5FmfEurujqMB0AeNCfl+iJhrWZK/KbGYTrMQ7AH
         /EBRVk85HywPN2gH46TjX1yF7UnICQpZ2rpm8DMmYXgIW21lC4oFOMqF88ZUn2kSMNeD
         uMJw==
X-Gm-Message-State: AOJu0YzW5Dm/z2IlwmzC462fX+dR71vSWWh8qEViHsPjWSV5cET5Nl2Z
	dmIDCfSWPHlrQ/mTtYckGPbJDI7UZo1Qus8cqxHJsW2NhJ8wfO1MdJatOFH/B4am
X-Gm-Gg: AeBDiesGsS1vovU45J7+zMkdGrK8Sz1OyQmkv6gncKYCqBnuKUSjtgbCVi8fqTKJRZt
	CwAjX1bXQqJhwS8i7I53hHuATNKFb/Q/sKleoGZUtxnT+7fJDqiELOVp0Pq93SJIQRIDSnyzmIB
	j6VrBs0TdRReb+NSn9AcvTTlF3cSOJvRqgxmozRDBiaLGZr9HlWNBuTyaJHr72Qb+LDh+0+fgVm
	FkoGeay6xVZHcRH4z30VLV1EPS7aQ9+c9AqYTCblkNBrKrygCImm/6oPUl4uft/rTpeq1njUEE2
	38d+hb5JEBHANqPAB8NH8iDTJaG9bJ9LIElHc4kCNDZiZDpdmDbKy17Niuife6FLk2ENcy0XiBm
	qZpcPHUl378urKvCTlPk9KqIzKVcpbxSEbtCcN48p8hrcHTQTdcr3jGO7sdlZb9bhS0Sz1ZxMbT
	a0aGuCfisj/TfsDJbsXN+NZe9U/yqq
X-Received: by 2002:a05:6808:4f0e:b0:467:a2f:b27d with SMTP id 5614622812f47-4789ff055b2mr7068581b6e.37.1776100307727;
        Mon, 13 Apr 2026 10:11:47 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26914667sm8863179a34.13.2026.04.13.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:47 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCH net-next v7 15/15] selftests: net: use ip commands instead of teamd in team rx_mode test
Date: Mon, 13 Apr 2026 10:11:31 -0700
Message-ID: <20260413171131.550126-16-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace teamd daemon usage with ip link commands for team device
setup. teamd -d daemonizes and returns to the shell before port
addition completes, creating a race: the test may create the macvlan
(and check for its address on a slave) before teamd has finished
adding ports. This makes the test inherently dependent on scheduling
timing.

Using ip commands makes port addition synchronous, removing the race
and making the test deterministic.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/bonding/lag_lib.sh    | 17 +++--------------
 .../drivers/net/team/dev_addr_lists.sh          |  2 --
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index bf9bcd1b5ec0..f2e43b6c4c81 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -23,20 +23,9 @@ test_LAG_cleanup()
 		ip link set dev dummy2 master "$name"
 	elif [ "$driver" = "team" ]; then
 		name="team0"
-		teamd -d -c '
-			{
-				"device": "'"$name"'",
-				"runner": {
-					"name": "'"$mode"'"
-				},
-				"ports": {
-					"dummy1":
-						{},
-					"dummy2":
-						{}
-				}
-			}
-		'
+		ip link add "$name" type team
+		ip link set dev dummy1 master "$name"
+		ip link set dev dummy2 master "$name"
 		ip link set dev "$name" up
 	else
 		check_err 1
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index b1ec7755b783..26469f3be022 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -42,8 +42,6 @@ team_cleanup()
 }
 
 
-require_command teamd
-
 trap cleanup EXIT
 
 tests_run
-- 
2.52.0

