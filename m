Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37AEADC;
	Mon, 21 Sep 2026 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966113; cv=none; b=Tgqz/fYk9g9+P4ZLOha6H8SCx8eYUQ5MITe028vxhPcVa+1iMUOtBcKFf/n/QA0rENrI+06gZmU0Cr6C9KBKOoXywJpNj8orrtfwfMxUh005f1vx4srUmeENnwDJ1LF7m/xQzFcgP75/BXSPHKvpLaVLdS2L5a7aFT6sckYskic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966113; c=relaxed/simple;
	bh=Bn1LkXeGGwqzMHuGmNASYhtZP0LvmouZf+N2woDBBjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRtSMhI7TBFiGzfH3aDPGzIIcYNNKu5eyBNvE9GDCOOIxnkHvr0mCuiZJtxiGts3JRiVFOf1793osqgh00++5L1q4QjMF+rFJDqFt2JEPsNG2NZtJbUVZcwjM90ig5Om0hHIZ/Blm6JObLfRtQMOUHZIUrmnloug7m3ZV2oHTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DLOsrckS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DLOsrckS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0OWrK8NF8ncxMBEJO/zL6zfb5m5b9T1k4FjJu+Mn0BI=; b=DLOsrckS2vesnuZGMPDhgjvQNt
	BLu31yUG1CwabLUe76yla7XXcDxmJksb5byP8ss8UyR71Rssm82px2kRsxHmkv3nhmOD4PI7W8W0q
	/RA8wLxhwuH1p2pvP+sULrj/qgnC5MXANt4uYqbc7N/gHcUFCtoJnPcWRY9XWbogWjqAySONLWBof
	hqfQrvuhtZNXbzFjqvgRAL9VqH8OA5LzDGBNcNwlGfNzzLpUntK8JUqDn46Dy5fmaEA0WRlJ/YCS9
	jqHegyiyrAMRwWLyLWaqqvoURKh9qLevwIOJvGnVgi83CBJPFMIlxDbog944yI0Kye32LgBx8qj4O
	qkSrHiXg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Vx9-00000000r87-2k9S;
	Mon, 21 Sep 2026 04:48:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: ABI: OCP TimeCard: use literal blocks for commands
Date: Sun, 20 Sep 2026 21:48:30 -0700
Message-ID: <20260921044830.95981-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use literal blocks for 'echo' commands to separate them from
the surrounding text. Otherwise the lines run together, without any
clear break before or after the commands.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-timecard |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20260918.orig/Documentation/ABI/testing/sysfs-timecard
+++ linux-next-20260918/Documentation/ABI/testing/sysfs-timecard
@@ -156,9 +156,11 @@ Description:	(RW) Used to start the sign
 
 		    period [duty [phase [polarity]]]
 
-		echo 500000000 > signal       # 1/2 second period
-		echo 1000000 40 100 > signal
-		echo 0 > signal               # turn off generator
+		::
+
+		  echo 500000000 > signal       # 1/2 second period
+		  echo 1000000 40 100 > signal
+		  echo 0 > signal               # turn off generator
 
 		Period and phase are specified in nanoseconds.  Duty cycle is
 		a percentage from 1-99.  Polarity is 1 or 0.
