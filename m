Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908D48F82A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035204; cv=none; b=B7FKtN4TYT23q78BTAgeZTTja3NTtXRpBaYI+anfMNQLnG4NbmhjNfe6JYTrDKCqP5hoX5jnuoHczS6zk044++P2qS8WwW+LjXS61/lXkLE/BS7Rcap2b8RBjpf9oEjspGpaPSblUnwtvhkxCsPXEp8Ir/4LlDJKpd5KbkGYP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035204; c=relaxed/simple;
	bh=J8Mf3HYZaTmZYQFkYELALEytTws8uvz/goY09yFk2pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnD+EjuOOCsTYrETWL3DZ3JR7jK6VjIurnhui8GBv2GoDP+u+XstM2Hc9EVRMgyQqDmOYNQAAfuqiHDG6+qwzU043hv166zlPchgJuwotJiCozk+CBD4YzRwGZKsMKjje2Nup4Dx3e7TNydANxlUMyTBLJdKQZO4GZ6Or+z++u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZeH802w; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZeH802w"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso29471245ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790035201; x=1790640001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=GZeH802wT7ZdEDiryypJYzjlclFsC85waUniUFFQtpKyQICaLHmzqfRUGdIqNgBvIv
         i0JexKwM0YGfy9UiOQhy4CNa2KjJYHJE4UdpVaMpAHZkqVq154369KpoQwPZoMi6N8HE
         zaJbW2tvmMjVcmSnBPVlH1r61nsPcmjhbsCsbYnzXjTovbG1OxSE+H++p/K7KoOjr5H+
         VEPAJOpkOamMxIsjZ5cemJLghkrf49ddZOPWG5vFm6SsfLI7D+UxZyvBUKCSGWmUiton
         miKRPdoLocdgM1QQLDMNzCWtTCWckmkeEb2P06TrZ49GisJdFAG1cZziE5p0mvtz9kRK
         VGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035201; x=1790640001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGK4SZ365cD9EYRGUuPJEEEIN0V6+rF/hbiJa0/JQok=;
        b=rjrfK8JrYe9SKPCG31VuFCoCVkJAZZchxhWda68BWCjsWldfXfBs3+iVK/NPzwtETO
         crL4MXlYPS39gW479atofOlivuMGlWw1zywRzWVhqQuuRblqez+vNL9qjlWawdO75EHZ
         tiXgxctemqDysk4LQKExr9mm1BhjrXR8v4U2yVcvbhNT7mDF/4tRT0lQqemQPvte9C6X
         XFXKSJkVDh7AcFLD56F63+5A0tLRx5d3afjYgjtrwDkyCLwy35Vmq9hPzYZ9Or5ZAo9Q
         mvmsDuamGz9IWbrO+YSSTSvebwm0GbF3UoXTclDQwDlgpEmKqN1BK9wo1jdDK9Eiqkrb
         h5Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxONqD1MSGwHk9ZSOM1osx10d90ga/HADFlYG90yK57wUK1onmO9pP7KAOX7OL2pL8XcueYjHA=@vger.kernel.org
X-Gm-Message-State: AFuF++nQt6eMe5QMz6YCrZWKhhgPCjaqlpH/29VL3uy7WU/NwT4TIv6Z
	EDEIeNq1fmrm5FIvFMwWfkKIO1FEUruI1xad2EreL6lwmo5CQBl9IuoY
X-Gm-Gg: AYBFou0UIqWw5nNajIbs+7YlTuKmuF4AKsQ3WpH4eHEGubzlZJ/RLtV3/nU1/cFxllM
	/lSXpQdvgPJsdqxBK6OHIXdjxDzCE3zvU1HEqZcfha5qiDyE15maw+zTk9kBULEIotZZvpwRgDo
	UbhKMUrinW1eJOePerJXLFGLzAzeWZOsVTRYUJtL8JANzEpIl0ywIz4k+9z4u3KEsfJ/j31Vkng
	uDx9feQQ81mTrn8R5FxE8xJVMEXgRgiM5vjDurpesYuONuROMG1a3WvckrcmEx0IbvS0+BGgaBx
	Ixnnmhzc5TkzIzu8ooGWKuXhEDImr1yhWT5z+bqMeTOE0X2dy76VJIqmydYoWqSh1JWx0dBCHkR
	udGVu/YhbYX2vM5NXuXP8dwPHFMWeVe8Mx2Jrr5oB5f1a0H/Ma/wQhTlnkBaTDHQBg/AXGQUknP
	EmZkydQB6l3kOm8K1bmkSt7ckjlj4J7Fic/8UW07sRg41RO4fnS5mmBhvP4Tf+MSpfRw7NxFnlr
	0uNEtej5m7cY/eUpWlwtgiyE+uq2Slnu8tXR9icku1xBPv890t2FgM+SwnQZFdnWf9O17VZB7O5
	Qg==
X-Received: by 2002:a17:903:2ad0:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2ddb1b78d1bmr200524995ad.18.1790035200778;
        Mon, 21 Sep 2026 17:00:00 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d045e78sm386135ad.51.2026.09.21.16.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:00:00 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 1/4] netlink: specs: rt-addr: fix the type of target-netnsid
Date: Tue, 22 Sep 2026 08:59:48 +0900
Message-ID: <20260921235951.3214-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921235951.3214-1-sigefriedhyy@gmail.com>
References: <20260921235951.3214-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
declares its target-netnsid as s32, but rt-addr.yaml has it as binary.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c..17ead2203451 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -119,7 +119,7 @@ attribute-sets:
         type: u32
       -
         name: target-netnsid
-        type: binary
+        type: s32
       -
         name: proto
         type: u8
-- 
2.43.0

