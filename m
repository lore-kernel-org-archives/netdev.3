Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAD45D1AB
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774784; cv=none; b=FQ4ae1Bb20vnTp03OiDKRO2x56G9y4GEqoz4INYFei/4aPr4yxbNIg7m8jr6lW1ZQkCvDmEXPF2c48DAGyrh9wpC9M+dqIunjzNhhSaA3lw0GowhBNPmD9QZW5STHvdDEcIZIBi7/5bp7NofwUsniXH8z2GPQevJePF+c/TtDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774784; c=relaxed/simple;
	bh=VC49h8ZegE8EDAYzBjHU86INCtNc6N2v+b3rWM+kMUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQv4DnyeG5vqbW6RDmnyUaxd4BXuhuhGYKcC+LgSH8dwOrLeuPlPPI7vEe+T3+PqbfOo5ARkrC/ssbAdpQLsy3d6+aTtueHaZRLK5Xeyvgs0pljZtr6Bu5A6CLi4NAhBKWWl/70HTckxXADddzYVYW5h7mXvM6d63M+fM9oXHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn3vVA6l; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn3vVA6l"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3653351a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774783; x=1789379583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YKjeRKSD1bBWDP9OGyk/DwMBtDEMpgCRWvQIa8t+vA4=;
        b=Nn3vVA6loxKspMKMnaVi1u3Cm5G9a7xF1g2AwFmuAFlxG+Yaj+lc4tK7TMRnOq8ab/
         JUX/A8c2AO9BV/7u3VB3SQ2dMXG39BR8akIDLiWr49uYi6fWUrM25uy59PdVYPnq4tk6
         oMuC5+96B57QmOaXMgujOoQJw+ISQcwdKzydagYHjGSuZhg1jHhUMMFFQQrIIUMWD9Mw
         KGPKkDhGFaUIM0jCsmrcET9fJ2e4cjlZGWgXvvC8PvpIRm8PzvRbPwAeNFo0cr8LSkcs
         u9Hsr36NKlb/nR2IoE/xLmAhD/H3o2tLjQ4pT7PqnE7WRDOJTHKrjDUHZLnDBd/t18iz
         285w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774783; x=1789379583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YKjeRKSD1bBWDP9OGyk/DwMBtDEMpgCRWvQIa8t+vA4=;
        b=SUZEPEUp1SAEEq+ODzXb+V9UeMlABvA5hKaAP29kJwbufQXsf5k0T5JS1cYujB2Lrw
         KoKQNG0PDNvGegfIkxTnQzYt9/BPAejgTI80PJYKs/oKwf6FhrfvbU1Ngjm9OW7haiVt
         EgU0Dm+vAChoVXUWuXU3b4GcR43gemNQyxDePm4Ph/SOcfDcurosogBkqUgdKhumybBk
         xaDsGAeXwZOkLu8NrfmbT7SSUMU+SacLCnnoPi6Y+W5sk6/qX13hOb/jYmF0HHvu3Nok
         o9bmJQ7GfXzX2YD6KEAj0s8RbWev7jvGoGYHY5GUvYDH+vDVgiTpKDf3KDuGl0oDKvyu
         7Jog==
X-Forwarded-Encrypted: i=1; AKwUvBy5hlJ5YYtF/Rg4iLxGbBH4TEab/fDjSxzMsoS4oBqFPWiwydXu7oZbpdeZFbcu6YkJPXAU41k=@vger.kernel.org
X-Gm-Message-State: AFuF++k7SzkgK1ilxElr/6+Dt/6JFjKURIHHLggiugc7P1XyT+m56aFX
	QKaBkyRfcRZKzFl5djdLpWnmC310RyMq3+qzsgkqICKr+t6sUL7LQUgC
X-Gm-Gg: AYBFou3j2bEQ84mZAkG1GphV/JavDT07HwGgEIJ9cA6vRtZ3tTNwAVIOLRhjBPPiiSz
	/FEDwYxcPxCkHlQtEsPrAn1p4tOB8SZAVzqq+6N63YIVFjldxTjyyrpkCR63TccM+gs5E8BtDrx
	pW8Eu80BDmUOiPCd+XPcTgm2x2jrdmOcnps4qOaczQYLYxj85FY1qYugw5OVU3eAWJQoVqw+fQ+
	oMDXF+dD2WyyQjfhyS82QWlHUDAbDtHauJf+nm3+E7cWSVnUFK3GiKnq3b1PWA2P1XKXAsOdxdC
	EWChbq5OwN+KCkNIE9pOIav/4nlLJ4XYISkutpTRCt664Ecjf8o5B2jU2dpuZVvP5lxQz9n7BW1
	4q+r05C8OewPTTfL+UGtQeRGmpnGf86kuZShk5ekYxZwsZub0TDr6hAdoapd0siqgqLfY3BAGCu
	JEDfQhBEjXHQkj9DPDbtOhIPZ5/RzM55TTrEXd+WLB/vkND4hERwmTQbwZuk8E5xPa9OyMchLpi
	BI2POvu6GNgCw==
X-Received: by 2002:a17:90b:17cf:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39b26216cf7mr32517925a91.23.1788774782797;
        Mon, 07 Sep 2026 02:53:02 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm18924258c88.8.2026.09.07.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:53:02 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH nf-next v2 3/3] selftests: netfilter: fix typo "adress" in comment
Date: Mon,  7 Sep 2026 15:22:41 +0530
Message-ID: <20260907095241.24441-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095241.24441-1-hemanth.selam@gmail.com>
References: <20260907095241.24441-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to nf-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto nf-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064239.39910-1-hemanth.selam@gmail.com/

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
