Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAC3812C8
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376658; cv=none; b=QnAFEkuy4O+6rBLUAvipYty0qsBPxs5wBZ2UvCm3m5q6e6FWuJli5Vr45pEqoTiQxAQYIjpDkNtMfoQATLMus5FCovmDx0vYLMjEOcpDno9xZWVB8+9SNb10Yj/hcXK3By2FmAZhThftL1dHMgpB4aJoYQYZnTLrTbgkq3Ihoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376658; c=relaxed/simple;
	bh=D+2EqPDkxiIP7659jXJBe6+HwYhGEbOa5dHouxpNOHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evX1FN4n7eKPeNExAp3uil9fE3trU7FtsiLEPDUEk/ONPXsC4H4SRWX6qfWe7QigO1+gbV5hZfZzmT7Uc7CpBNw5qTh0W9ITfox546dRgCmL1xdurphoUBLlKsLIzcLY0xhM8Fz8KZ5ngiK3WBfrdnyS9GtzfbvgQkwW/avk3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiV0d9If; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiV0d9If"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46def4bd5e8so249276f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376656; x=1782981456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J1jnzmQVNhnRjMNcripM0zyo9VQmhoRd3tOhETxEs8=;
        b=FiV0d9IfxleAJlGEoGlvmiMkRrULIYR8hhuIdDMze2XplYzVJt3F+WrT6jZs5TDmxp
         Jmz1uLTL6mtALma8rWFD/U19FLqHTNkuWqP+acUqEK5YSten6qMKZ/OXBfqIX9k3+PBl
         1lKXyzDWFGJ8/wez3NxDniWLWIevdIsoRIz4uxopkhwzt5leYD5T9tPQQRhu7GUc8CQK
         nHoECrfsBbnM1/WV1hQY9xloL7Xb7DSDCtv87YpCTnMw/970CvHgvQ2w93mHddmlK2Yb
         JQqCwSd6JkwP5TuA5b5bBDSIG2BQFg7Yl1AzxXIrWAxzN27GRxzNBntEdXG7D0kO+X46
         JBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376656; x=1782981456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0J1jnzmQVNhnRjMNcripM0zyo9VQmhoRd3tOhETxEs8=;
        b=QfJjmgtaBx3bIbyS7kI048tNZok0ZFbzrNJBiHS9Xz/2aq/cmGDLHxLUqMUL6gb6dw
         q4YcNwbyu8jJIoztavPfXluc7rdKTrO2YkqfICW3ewRqsnW5sSfP2dMB1b2OWMDJj+zl
         lHWbpHgB3cTPTisfjfhHob/34VvM+TbpxBEZ87/DGgW+eH7vJr5NRDkoMbqvm5XhQIyH
         ZBsACPEuoKgKNu9mvQ3QzAXo3pXGq6Xz8KSfycXsFxsYkwZe7CqF9rY4dhaj7qNFHVEI
         eXQ0g5jXL8lLeyYoc8CSjTeV27NEBHwT7VP4kQy2Z8hIrB02f8hw01x8VOw1n1XQOZaf
         eVKw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4QNtN3Ya9oYjXoQL5dmpiRkZRneIaVUrB4u6+YiqrgDUkFKY//W7YnSJZFag/e6txiKqvSNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNixwxcLzT0UtaM6GS7W8dWuZRd8wFHVQFazTSumG7+4vxqx03
	5YhuJT2v0nb4OaYei5MXzad12NI7D/yyCEiC3+4ycMBjZLjX5XCuL+jT
X-Gm-Gg: AfdE7cl2X8ohepEEWY9/mljOYhpRT2S47dG+r6+iphmLYJcft1wEykZr8phxfDbmHym
	DZXCi2GP++i4MHxbw0EMYrgNapPgTgOr2XZb3cwWmIhVrlj9R7Nsi+agPFks3TCA69JTgTOVP7O
	TxgerQQOZhMh5kDYHgv/S+YTCrc09P5SsQECvHPY9uePMZ/73sInAWsuKa4CJehusqQmA+EAhH3
	zK07TI4dHRl34bwT248NRwNBNvxCL+UfNa8N4j/GZ+NwN7DZOMnns1WCz2rzQZ2VHceSdg/fhXj
	2n1uzek1yYwSplicRA2JhUA81ISoHQqWNddrNoeZXEiunP4n2yP5pC2kI96MR4WFHTH6TuW7i5W
	HSmJdKN3wENnkWZ/rAM0n2ou4k8RI4JFYocbTYuCZP4caApknUFByRgje3JsDEbT7pEmKn1iuXr
	Q6Kq5mLMUvGC31FRDRV4U=
X-Received: by 2002:a05:6000:2485:b0:46c:a463:987b with SMTP id ffacd0b85a97d-46dc1e82faamr2365468f8f.41.1782376655597;
        Thu, 25 Jun 2026 01:37:35 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c9ed7491esm9943798f8f.37.2026.06.25.01.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:37:35 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 7/7] pipe: set FMODE_NOWAIT for named FIFOs
Date: Thu, 25 Jun 2026 08:34:09 +0000
Message-ID: <20260625083409.3769242-8-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CRIU relies on ability to do vmsplice(SPLICE_F_NONBLOCK) on named FIFOs.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/pipe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index c0ccf21b9..a8e9b4459 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1156,6 +1156,12 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	/* We can only do regular read/write on fifos */
 	stream_open(inode, filp);
 
+	/*
+	 * CRIU relies on ability to do vmsplice(SPLICE_F_NONBLOCK)
+	 * on named FIFOs.
+	 */
+	filp->f_mode |= FMODE_NOWAIT;
+
 	switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
 	case FMODE_READ:
 	/*
-- 
2.47.3

