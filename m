Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAD3EFD21
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394592; cv=none; b=iX5j3tDZdIB3Mb4NmR4SUKJ84oVjnyHRYg61UYHU5RLx7oQBJsqZFhgAtjYO9OPg0mAmpVUmWak/zBMNfAm4lYq+ePjBvn6WLslnRaPRDJyoMjIPUDGrlYE7mKqPLJ3n3qGBTlJLp8kRvaOkyl1drmKmelXL1Ixck6T0UM75J94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394592; c=relaxed/simple;
	bh=KbWyKGSxjhF5GejC0AxphlWLzf470Pn66p11+I61qxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlNxyEdE6dJbzVBVyCW4U4pWx+//Yz8gpFojbdME91b4ZxNjfvuZKY+q+4rVos8mQo6IuhGjhTRrioJPQUQwT1UJFJIZ1cxSREonkc3A01Xons5UqEv7LGTBsP6AiqBF0bwQw2V0S8ul7aIayHG1SmXkFg9N7MSemWAdRaNJSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=VwglqFwm; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="VwglqFwm"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917aca1aee5so56728496d6.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394588; x=1791999388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhgCXPltKa4ugKSRt7TE6+dyJRKxsCYuMAHN+j14pAQ=;
        b=VwglqFwmTqSFngVk+qRbOBNF0DRsJPUEVp/3Yn615xomdKHFJJiqziPd3CJVjhAs03
         k1aXZDhOTIv46SxSO+1YaDdfseFcLFeCPtLyQCMDUlyMMgFOu5mqTSwKVlhOpxDeaUSK
         okwDQhMk9CIvLeAGtIKT6oy0kg48PUnptobw71R5tWjsJeDfVdzRK8Ghj8QNcTg2n/PZ
         lUvStgujOlpIhiv+k8HlphYRGk3f0Xsc6xR54yKvlzEFfrsWtUJJGzPJu4jfVBuNUHOr
         1hnTR2WEoyEZoej4KhshFAwZ4tCm3S8yp1b1jQOXPQ5w69FCBr2lBGmpR95WtdepPSb3
         EnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394588; x=1791999388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhgCXPltKa4ugKSRt7TE6+dyJRKxsCYuMAHN+j14pAQ=;
        b=Q6M0riTFbAIilTNmXNDoSt8YeUTHhOuLQWZ5jm70KZor3Mt5W/R/pDepsTdfIAFq0t
         hGQ4xOFxxb9eP6TOLdGgmKow3tHHwgQz3XbpSfU4m12IsW0VpiUGizHytMKw1CoP7WEv
         fcjsbY1FFMTgJKCaw16WIPXXn1Pei6lAcGjizskJXNcXHbRT5n0pUyEVLK6z9SU2nnon
         Hl+Pxuri/sTOe2cZHsr6XAve4hzqiv5eBIktb/GEDyYvUm+4f7gxQp6rikJbiQMpKCt0
         KjiPrn/+OoY72b+94hcDCq/Q8yFp1uDXW2QF+hG6qdQ31sL/S+GQxLmi4qe7K/z7t/j1
         V06Q==
X-Gm-Message-State: AFuF++mahT6PTx2aICdVCqrrJPNqUyTz38h007qiTDQ9C8GEOb6JIkmT
	3MjjMZCd9vY2bwS21ROYKwCWXkJYbs6njUGxZonCsuLG88ws3dYF/4p2duNDAWSKqYQ=
X-Gm-Gg: AYBFou19IrdqKHOfevE+6N/6jIV1z+0uIfSyiHDO1SgpzPeoxKU1maZm+9njmHvyQZi
	f5HqQQU9CRMbecXxSofCd586mWAT2GeIGQQ00WEx7Gv7enfPKteD1oo86gwF8B9eCr4x1pPCuDl
	3V/NO1lsL9GILN6d91+I7rh7vgQVLHz2L0Pqc8VF5llPiyN6EN8YKakFRydOwWOFnD9fhHrtlDx
	KeI5s7kdXbRhJbKHbfGsdKR1P/WGCIRr7vvIvOxBgLHFg1YyHD05eTfgYSSC0FS/264s6yBYPoa
	D9FzOHFb/13E27tKxYdtz5g2Aa260AJGDaJ9aHCTYnG8SuMvoiEmgtQ5cxwQuF/52nT08O6HENn
	1GFCPflyyM4wYIZtNp+KWklJJ09NmVvYzTHmbId8kx+rnoFp/Q4sxcrkXZ/NaoKx86PKbB6aUOO
	LPL+qTepm1vu79CzTFpVJB3YD6rIQvC6pNJ5LRMwM6ak0dq2iOc9It3bTXvTsJEItGHxB0plXMk
	j0/GY0AN30HM7A=
X-Received: by 2002:a05:6214:29cd:b0:917:70d7:980d with SMTP id 6a1803df08f44-919978a2b9cmr54768766d6.42.1791394588468;
        Wed, 07 Oct 2026 10:36:28 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996d55534sm24883916d6.35.2026.10.07.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:06 +0000
Subject: [PATCH net-next v2 7/8] net: skbuff: don't BUG() on a missing
 head_frag in skb_zerocopy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-7-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=1048;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=KbWyKGSxjhF5GejC0AxphlWLzf470Pn66p11+I61qxQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFtUcSnkhBjEUw8XnUzw4gXlovZPDbuxbbpSLWy7vpytOS4USmgR+A1/4ZSStagI1sQaqZeQzzt
 +rMkHZGEDZgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_zerocopy() BUG()s if @from has no head_frag and the caller passed
hlen == 0, meaning the caller didn't ask for the head to be copied and
the head can't be referenced as a page either.  The check runs before
anything is touched, and skb_zerocopy() already documents -EFAULT for
bad skb geometry.  Return that, with a DEBUG_NET_WARN_ON_ONCE() for
debug kernels.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7fd2f8142cc4..629de22d98e4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3913,7 +3913,10 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	struct page *page;
 	unsigned int offset;
 
-	BUG_ON(!from->head_frag && !hlen);
+	if (unlikely(!from->head_frag && !hlen)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EFAULT;
+	}
 
 	/* dont bother with small payloads */
 	if (len <= skb_tailroom(to))

-- 
2.55.0

