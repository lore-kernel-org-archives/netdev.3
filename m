Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062A288C2C;
	Fri, 31 Jul 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458424; cv=none; b=kCy/Nyy/hNSAk0wrAIINidYz2DTs/yVCofL0rpH4L5oeV3G+24lBPuQJpXEwcBQ/B8GwQ+n42WSnhuztql+96ndYCr5ozNNDWUZHRU+GEFDO0dsnyDZqOBHQoDg12aWgzy5xDtuwsSicK4N3N4MY96CSFy5vGvAmXt5VBSLjyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458424; c=relaxed/simple;
	bh=IqjfyMPn+IFcJKCpby0Z9uOv8oIL/F7ptYzWzHOXO/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wc8o9iH9wLCR1j+UVZzDc0VeYjfMEcggauIi3wdOh/eUyE/0OsREiZaeKd3KyvSf0qOcPPo/Q0zS1HTzy6QjxJippLYQVcyL3eDxyg2ogCaP751vnp0cTB8f70ae1MAKWM0YUWR8D6o3ede/6Kpy1/3DNMA2Jmk81QaGq/BN2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuI/URj6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuI/URj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B363C1F0155C;
	Fri, 31 Jul 2026 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785458421;
	bh=7p3RjUN95N6wCw4ms8CCm+fdMgZ4nCppLqLrFAZAAmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YuI/URj6+Vi+efweSClmewoGubbClZ0juzRUVB0Ku+WIL1jOetkUuuiscd5LxKyNP
	 NZx5qXDlR1ZYNbkE5bBIk7v7Dnd8wf/AADJ+wfaRkloCMKFCQ7PlwIs44N6Ose8Hyd
	 r6w70ePDToZ7S5nhiG90rYANaOwyorvc77NtzK+7qWN240wT3ZosAh5+qn39qL3JS4
	 iaaaqd5CvKTQiU8XS3cwk75wczia1B8pyjKFDpJFb0rNtEsNhVBP+xzE1X41zn28/i
	 /QgyiQz68viX5mZGL+w3H0TFO5bj+OaRuKICAj2dKF/htdAesPsFmytsaQ90EgxwQ1
	 ZWMd7S20RA1ug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4665DCE1059; Thu, 30 Jul 2026 17:40:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH RFC 7/9] net: pktgen: Use accessor for hrtimer_sleeper ->task field
Date: Thu, 30 Jul 2026 17:40:17 -0700
Message-Id: <20260731004019.3530210-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
References: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hrtimer_sleeper structure's ->task field is used as a flag to indicate
that the associated hrtimer has expired.  This means that the hrtimer
handler can be storing to this field while other code is loading from it
to check for expiry.  Note that additional races appear for hrtimers that
can be restarted, which could be argued to be a user error.  However, that
is no reason to let the compiler introduce additional confusion, and to
this end, the hrtimer_sleeper_task_get() was introduced, use of which also
has the benefit of avoiding open-code access to hrtimer_sleeper innards.

Therefore, apply this accessor to the pktgen spin() function.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/core/pktgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b31828853..f4a6be18267ddb 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2345,11 +2345,11 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_ABS);
 
-			if (likely(t.task))
+			if (likely(hrtimer_sleeper_task_get(&t)))
 				schedule();
 
 			hrtimer_cancel(&t.timer);
-		} while (t.task && pkt_dev->running && !signal_pending(current));
+		} while (hrtimer_sleeper_task_get(&t) && pkt_dev->running && !signal_pending(current));
 		__set_current_state(TASK_RUNNING);
 		end_time = ktime_get();
 	}
-- 
2.40.1

