Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA33C0603
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682540; cv=none; b=fba/AiKMOsnDqKXjuQMJsb9l86b/e+hB4x74KGjjWveOYFBTadKuAL2XLpvRCaxbAznX85CS61Zo9gwuMlA0u/mL/5GabggjjfNOQ59sP84Rp5hIT7jKnW78mWVXd5LmeZi1MiIPnUHIFx4F6ElJjgPcZcdCXnx0QToYMWNdufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682540; c=relaxed/simple;
	bh=rgpUQ03/ZRwmftZiSRYz3nqptGqsmJfMWVLn2DiS6iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=obMs/HpAAWbFPDm8q2Gs9jolDG97XkmSuH/5HXCDtby2p8KsngW5ElgxszHFJ9pBSFf6h3S48kqXe41tl7BXO4jGG3tHZo5kkUFg2SxW6qVbGPvJMAkRFg2ZqLFaTiYMrGxVQSNBVUG842IdfAkIFtj94ncxrnNCVPR8uKW6pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl; spf=pass smtp.mailfrom=isec.pl; dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b=YinVuTZO; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isec.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isec.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isec.pl header.i=@isec.pl header.b="YinVuTZO"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso842935e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isec.pl; s=google; t=1789682537; x=1790287337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SukXgKIMuyP5Lr+aua02ez51DV78Bww+w3rfMakMJUw=;
        b=YinVuTZOan0GlJwGceyWI7h3CXk/WyH5uvGJideKqtQB5vhWV4BDFo2DNLGbcrIgwo
         QOufiZtpW5Lf4K2O+1JF6sdeRuFe4WBEabSu53+avak2a7Six0oR5hmPVBFpEGggJDQq
         oTJpiJCP/+RpRnlWu8S0JVhowTxm33G3KkREQm+eYXD7dCIW3eP4wFlplnRcr6vpk3X7
         2OIdCXb/ll700fbfSiFl435gkEr/vFoXZU21yHqutdQZmC78MZfRgRqr6pwRGDZjRA2+
         Zj375v2mikQtMLNuFxzGcqI0sgX97LLJWXTufoNRRmxzhJxY6lmsGhrpUzegQYVUM0qA
         QYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682537; x=1790287337;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SukXgKIMuyP5Lr+aua02ez51DV78Bww+w3rfMakMJUw=;
        b=yHfIcpPbibaQ4e+vlHwZbS9IjYxKA4JGxYB4wnpC++I6xkkkm9TTdaRQOjdOTAVCIN
         30VPA4qUWSS0EQlBYxy27VPj3PyMOyOw08fX0dCUZ2OLl9PMyLoUr/sewnUm2jeczCLC
         wJ4N0CaaHobcFXzOkt5PJi+PYuXjJSchZO4CUDbv8ylKNijcj8P4N9DeNE4QHu9/kRmy
         Q61HczIX5GfuCMEQqfpUqCHfhxr4upm72IDE4JXJsRXBg5jBGCYr0YqfjkLtFFmoB5NR
         G2RZOWCi1xqqvVcj/+MIMuU3snybOY6XhiEDM+EQp4m4jHvVV4ZbWaglQZvl+exhYch/
         jlZw==
X-Forwarded-Encrypted: i=1; AKwUvBwbtmcMQrTgOHR8jXhdHg6fw2qK12gyqhcCkl5emY7JDgN0Y3AhlKW/PabW6qaN4GJATFlJrt8=@vger.kernel.org
X-Gm-Message-State: AFuF++mxrE5+FOxqu/YPuJhyxg1kRSV8O4bhYqmQoEZ1d7X0HvYOWZyp
	bpDw0WXc6DFfEPz6UBm+/JbO2GzSx1o3rgloqtOF8/1ODZ+r2AYT+x5Kl08/p2jCS0U=
X-Gm-Gg: AYBFou0PDxFPwaFg4m/7TS/F+NCqfZaQBA+xBMOa+NFTa1lk/UVkGLjjTqc3bY9lPJK
	jRZeJChm7z8DeTqxZbt+bCyNBPLTpVPWfD7uQh7rKCTZCQWhC5novZtkqSIDpR/E718na1B2BS6
	fvGB3D3jzyxFO3HTBrxqR0MT/UsrpwGVxsMvQBMvksY+Znl0rMEn2YUcnZY7/W0pFlEVRr9MzNl
	+5RMStfN7/+HXiJLDZJd8VG62mDPGxU/w7l+x7P4W+dJ5p3STj1qOrQVjbL+aOm/Qi5Zyr1zC2R
	KGVHguZqOgxkfOwwSXFpyhBVr10tEoBTD4XrZX8lUu/QaN14DRuteXx504x+qV2zEqCFzsK+u99
	vLAqB2FZXiJEyQuZn1du44uFc+pSmET/FSxk6fNVrfaH4Tgwg0ytcnwpRj2YX0pmTVSda8SlVKI
	KM3nx2R5+fGeA740VtPlNdEM0QjhF5AhYS9stx80dGj6gurpdiVeIVaMaPZ36XiW1JPqYO5EhaC
	Vq8L6MTk75CyQ9zq2M6esphumFegPxKZ/Y9N4B6NKQu87M=
X-Received: by 2002:a05:600c:3b8c:b0:49f:bd3c:bc16 with SMTP id 5b1f17b1804b1-49fc572f58fmr3667005e9.17.1789682536706;
        Thu, 17 Sep 2026 15:02:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a318:80b3:9080:dcf7:fab7:9a22:85aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbf515cfdsm98532685e9.11.2026.09.17.15.02.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 15:02:16 -0700 (PDT)
From: =?UTF-8?q?Bart=C5=82omiej=20Dmitruk?= <bartlomiej.dmitruk@isec.pl>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races the delayed close
Date: Fri, 18 Sep 2026 00:02:12 +0200
Message-ID: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hvs_close_lock_held() takes a scheduling reference (sock_hold()) and
schedules hvs_close_timeout(); that reference is dropped, with
vsock_remove_sock(), by the delayed close.

hvs_do_close_lock_held(vsk, cancel_timeout=true) drops the reference and
removes the socket only if cancel_delayed_work() succeeds.  When the host
rescind callback hvs_close_connection() runs while hvs_close_timeout() is
already dequeued and blocked on lock_sock(), cancel_delayed_work() returns
false: the reference is not dropped and the socket is not removed, only
SOCK_DONE is set.  hvs_close_timeout() then sees SOCK_DONE, skips
hvs_do_close_lock_held(), and drops only its own local reference -- the
scheduling reference leaks and the socket is never removed from the
bound/connected tables.

Make the running timeout complete the cleanup the rescind path could not:
when SOCK_DONE is set but the work is still marked scheduled, drop the
scheduling reference and remove the socket.  The two cleanup sites are
mutually exclusive and guarded by close_work_scheduled, so the reference
is dropped exactly once.  (cancel_delayed_work_sync() cannot be used from
hvs_do_close_lock_held(): it runs under the same lock_sock() the work
takes.)

Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
---
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -499,10 +499,18 @@
 
 	sock_hold(sk);
 	lock_sock(sk);
-	if (!sock_flag(sk, SOCK_DONE))
+	if (!sock_flag(sk, SOCK_DONE)) {
 		hvs_do_close_lock_held(vsk, false);
-
-	vsk->close_work_scheduled = false;
+	} else if (vsk->close_work_scheduled) {
+		/* A concurrent rescind (hvs_close_connection) set SOCK_DONE but
+		 * could not cancel this already-running work, so it left the
+		 * scheduling reference and vsock_remove_sock() to us.  Finish
+		 * the cleanup to avoid leaking the socket and its table entry.
+		 */
+		vsk->close_work_scheduled = false;
+		vsock_remove_sock(vsk);
+		sock_put(sk);
+	}
 	release_sock(sk);
 	sock_put(sk);
 }
