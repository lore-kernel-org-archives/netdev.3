Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983B38BF9C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763383; cv=none; b=IRAX87ormPHXFdJcuruGOrTbyzwk5dGdlsFMiSL94H/d+SBI0CBOemGxm1vaKm+mUY/rHRXOMJT+ZI99mFT/tpSp6XsowFbi7npeuE0ajtMeds8SvCxgZ5is8r481rhE6ArkfJXuxjfEFHC3OUNQTkLRmCO79MP7s336w9Dq65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763383; c=relaxed/simple;
	bh=EvsfQPT/ZZJn4x5DD3SjcYa9cZxMuCgoNBet5NpUjAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyXzgjPYKsZGRm80J+8s2vRBU5oH99AjcYTnvboIb5I8xSZFzbVniQK9PU8I8v5LwxSYCAjRjAGhLv2XCntpKDYfZ/CysoRgU7oKyo44ibxDW8OCmFijt5HeFoNdAHKuqXNQbxRxK5OolMebykRmULmoZ732LfSItc377VP/O1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deCKU/Zf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deCKU/Zf"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso3275921a91.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763381; x=1789368181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQkuZTN3riPRwhHG0AF3YCCoVsjxRpa1rRlamTcDEHk=;
        b=deCKU/Zfx414/0gMHs+fb5T7UhC0PTJBn5B3hI4KI71j0IHjDJfNi0D4jGcDkclMJp
         edWAkOcT0t47ScOj7MjlIMzA7IqdHSOL3Ldi/xUFNskCkOsFOxCDcsLx7rktNMbLqUXW
         FLQx44fgWdj1q0jyj5C0++HVxj1/iWF3GZ4b1bxve60JRHPO4EJfbtaxzv9jwgX8rSOr
         ldBcAgGVtcE3HFIS3BYqwZVR34/Qrp2B1TqMHZa810eu/nvSgBRRS9vDQQkKkNYuOmwA
         F91sI22QuE8sH+F+uRlnl/9Eu9TY6PKN1DXbETVzc11VA/DWLxB40jQSmkHPN80ksOBo
         wE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763381; x=1789368181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQkuZTN3riPRwhHG0AF3YCCoVsjxRpa1rRlamTcDEHk=;
        b=GULAdtAsm3i8UWNMlp2W4ZaXvOHRtnMU8wc0KnnhI2A9Uk6tAN1+SZyAbe68VjLd9Z
         W66Y+oMeQWvDUIpGSO99Kcs1mwV3tUmhkS11VkwZG1Ko1h1K3qExEG6nHjVyKEVJPFTH
         BuGHZ9GNnDDg8q8rE0oW+aXJZV2VN0/wocY/drtL8tSIOZrHLvWJ2FeLGsupwMSHgZ6j
         nmWjgBEK9X24t8XCaNAb9BTzuOndOk+7/AfDTNls6/hfvQYMbGakoltcWA8JN2RDNpiq
         WCaoR9FRr7tYNz9cDDtTDLbbv91o2vxDKKIDT8BTbe7DkOQYROeddTXWg7G3q9KagA2/
         F1xQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkLCpauq6KN6C0GiYsKSO5IVehgG1hCLKWR9Q19qUW2hBCZYIgMnHYOeSJfb+HiARSaehozWw=@vger.kernel.org
X-Gm-Message-State: AFuF++m46mcopRIt5j20oXvdqc7S110zyzA7gOcqfoio3oIagwqyRcY1
	Ohfq2BJXZ3aKI12k5HbU9jP1H6r4iCPOIev5gFSO9uUn7RZ3kxm8JeCE
X-Gm-Gg: AYBFou3rqDjdKRaYk5ILEfadYIGNFD3VyemRdnAVKh3pB+M3Mc8a+qHNtbCiEfsEspU
	uzRlEMYFt2mpte5iHaIDgbqVnFtTdNlsHaLmIbmDopuLdX0tKvefHNi68JRCqJ9J1Bj7tmE27Rc
	5STCRc/i81ADIvjd5YYJbiQf2j2a/y7SS7XFpxrZ+ld1Y8exNymr/CC/zWr/lTQ8FGcY9PkOWWZ
	4pErTDEq6g63Q1NYVK1EQzsvIwUZUXG2Pyb67LG90KaUhYGVu5lINIE1R12sQGFzJe58RIGk6VJ
	tp3+iiXT4b14P6Rh/TnbjQFEo7YdzgKdnM07ZM6MEZU5GFjX3ApgZG4Aaqfm8nTDBb4S3Hv4km2
	2h1uAu5+/7ss+wg5UnUMAI8q73nXackKys2Mdaf3YDOea2K+3SqMFjX07Kv9TAu9JdqACINN+/f
	vh7B95OLvo6yJVAzu9KHClT0mkgz2chdb3v8B9/6AKkZ4Ci1co1ctN1ueKOGsl46A+9Gzlj+6Gm
	ova48jE1jcENQ==
X-Received: by 2002:a17:90b:582d:b0:399:e97:8d5a with SMTP id 98e67ed59e1d1-39b2627fe18mr32320608a91.25.1788763380957;
        Sun, 06 Sep 2026 23:43:00 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm14377817eec.8.2026.09.06.23.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:43:00 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests: net: fix typo "adress" in comment
Date: Mon,  7 Sep 2026 12:12:38 +0530
Message-ID: <20260907064239.39910-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064239.39910-1-hemanth.selam@gmail.com>
References: <20260907064239.39910-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "adress" to "address", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
index c63d840ead61..f63b7f12b36a 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh
@@ -171,7 +171,7 @@ table inet filter {
 }
 EOF
 
-# make sure NAT core rewrites adress of icmp error if nat is used according to
+# make sure NAT core rewrites address of icmp error if nat is used according to
 # conntrack nat information (icmp error will be directed at nsrouter1 address,
 # but it needs to be routed to nsclient1 address).
 ip netns exec "$nsrouter1" nft -f - <<EOF
-- 
2.48.1

