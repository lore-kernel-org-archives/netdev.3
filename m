Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D5375AC3
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139116; cv=none; b=UDlwBhfnsEhjT1me81YwB0nR/St82ho3Ze7Fcrjn3dOPcnmMNn3sg+irfqSkzq6sunONcf8n1o4pSXOX7V6Hg9NSWOARr787OXgR6b4Nn0f2KKZ8Z5o/OAFuvH8hqSFffNjRCo5GCagDioFklLb2tAASJikh5lD3upU9HoxT2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139116; c=relaxed/simple;
	bh=SulItpOpA28ukZfWYCS1+ezWXd+i3c1ust4snZvaoAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4G1rkOk7E02F9HLJX+bT29P5EtqDB1HskaYZW7EgQFCyj48/VZq8tuse5u5lcgGeKJZeLDJJla/bDIf1u6mDIipL3mr7Q2cYmDrII2DhMiJjUYqK81wZUU3ntmi2SrwoVusEIALkw6aMEDGNbLgZ9/HUFIZNpzMfd1qgJ3txbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dpY9Vw/W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dpY9Vw/W"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso12095475e9.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789139112; x=1789743912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7/A+IkvGH5yYLsl3B/FA+2ENzgeK330huKjO7uo/XWA=;
        b=dpY9Vw/WbRSQ4vAmcbMbVsDNf97x3fiJTZq1V3vuarPpkrVkQMkq7Qw9A3NT1MpM+z
         L3pCZuHMbsVeZ07kHa79dndIHXwQOCQHY9dcRkLL7qpE1CdxelO59oqkVSOBO5Qd5eNk
         wxQy4TkrGLSeXDH8DQQ/XCg7NpAnbvI1BRBPTHihUJqcg8DnhFFThHW3iT/mcEpbP3DS
         IKx8LonNMoHEscVCzKZsJDlxQZ6poGnEY9yZY1WhsCLpJUNdV7vT30jmqvxP9HVX78cf
         ZLbcHsOOADCJZ+kzBfHM+AGn/66uFYWxppyh3qA1RSoPnSs7px5U0GxR+sv5+QCbGRzL
         aA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139112; x=1789743912;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/A+IkvGH5yYLsl3B/FA+2ENzgeK330huKjO7uo/XWA=;
        b=fveaXZpZFNbkhQhK1lZoOaUAR6lwbb33Czly4z7UNISMKTSOwSQ1Hh9L847SnScTbf
         UqHP02Bolz6OethBk7nFk4ftMYaOn5pUSKOjQn2hcWGs0nmfdnbJ20keDaKrosWtoVKZ
         przELmZST0fvJRBvPqTjUgdLGyWf0l7hv99BYNAKpYE+3VVF35qDOaEvmljFBchDD6a1
         GBRDsZkGaIWWvD0ODOEBv+hVviLSv4Vjo4InEf2cRyry2ln+xxnRRkiEeX2x5gCbBCIo
         B9Mcmo1bbFPl//6oYdqU+5anUSs7+WONw6LTVJ0saJOG+2Zgynn+B7IuaWyk7GZLO/MO
         lxlA==
X-Forwarded-Encrypted: i=1; AKwUvBzGiFpf3Evwwyil/3+6rJuSGoYTwBjH515IeENyMN8NPuh4aSMluq+mUmBeb4G0p45EGMeJh7o=@vger.kernel.org
X-Gm-Message-State: AFuF++l4XZIt9QqRidDz2CzFUN449YPj+OW3pPhcw2nPV1f1OEvKFxXH
	Cw7KLPOU3eMOmlprPKfW4gRqTt+y4ZTEcVBNEpyvPKmIUV+hzzqPt1dR49LYaBfZNjA=
X-Gm-Gg: AYBFou2bVgT1L3ZVKNauYdoQnuoaryV0hfLLTE7dckJL80nrv2PLNETC9mrrQ5n++C0
	6W7fGnVavr5k5YQJjqjUWmLWhb+mz4uPdGPBNljKX9jLueQ/WkPcLw+7XU6VPnZokKsaVhdV1dH
	2bDvZhvIqNkVVf9hsqbpD202ekkbYl1KHgiPZ+dbWyIkj+yug/R8fVLl0RmQ5HmYa2nK556iHQ/
	Eow9zbdKCRoSQC54zu/KVci3rFETDUgq+aAx3QlRYHIdQcOPH/swUvr1I9thxWPMtp1RP3+PZ97
	Kg9VI1zaamdbS3XhtoAuPIsRAxJ2N0T31nWwcATXDGa3LilkjnIXvaD5YAQL2qq066YrSIqOdRg
	EPHK1RLyDXKTZVOsxPBChX9rdzAFGyTzEDBLh4xHkwvepLQapo8CiqsInuikcRqH7/RMcLP2YQI
	2iVSjIL/8zgSe10/n9bCzxWqBfVEFw4/FPjYhUCx/8D/7GZM6yMmhe3tX0JanB6/I=
X-Received: by 2002:a05:600d:8498:20b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49e619c6eecmr39713085e9.27.1789139111976;
        Fri, 11 Sep 2026 08:05:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6853579f8f.27.2026.09.11.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:05:11 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Francois Dugast <francois.dugast@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-block@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-api@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] syscalls: Include error-injection.h for ALLOW_ERROR_INJECTION()
Date: Fri, 11 Sep 2026 17:04:03 +0200
Message-ID: <20260911-module-include-error_injection-v1-3-5da895d8c84d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

include/linux/compat.h and include/linux/syscalls.h use
ALLOW_ERROR_INJECTION(), which is defined in asm-generic/error-injection.h.
They currently rely on that header being included indirectly through other
files, typically via linux/module.h -> linux/error-injection.h.

Add the missing include in preparation for removing the
linux/error-injection.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/compat.h   | 1 +
 include/linux/syscalls.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8da0a15c95f4..ad37ca617e65 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -18,6 +18,7 @@
 #include <linux/aio_abi.h>	/* for aio_context_t */
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
+#include <linux/error-injection.h>
 
 #include <asm/compat.h>
 #include <asm/siginfo.h>
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8413b624ad47..552d9710a0d5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -92,6 +92,7 @@ struct file_attr;
 #include <linux/quota.h>
 #include <linux/key.h>
 #include <linux/personality.h>
+#include <linux/error-injection.h>
 #include <trace/syscall.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER

-- 
2.55.0
