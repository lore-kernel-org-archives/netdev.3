Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793444926;
	b=k1KhpmEUGOJXUbeRlrU73+WMfoncScrrBOKMJP20SZ03CCkpcRXH7yXtUHVvupSPRXZE
	 hrU3kIDrHe4uozwF//TCxjfc0DOl0B60JA2/aM9+tREJUctgnFAM7p2vTCOxGC4+nBszc
	 kSb6xv/KUYHK1M04WTxZwugNgU1DewB6z6JuCVo+694vFpJVp7aJqW6HbMqmR/8MFVSdO
	 M2Jw6Yo93jGd8WaG8yKp+Dsh3slDwB3eIJjH1gmL/jxhgJUz+mz9KvLWkrGecofXbMyAH
	 9jNPKNVuB6TjTdB27OVDAr21lXReaQHZuEn+/Zm9oQbdEsYHEcqH5oSwyQnDIAWnyDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qn1VaOGofv/ujd8ZvwN7vtgFnr5O801uRmpZaOHHctg=;
	b=dXlv2fNWqKAeQ174G74EsYOp1Qj97cmYHUyTxTuDONYFXndamLZ8SpqKznPSIAywsVyu
	 UdaG1uRTJi5kQffXn4GwXlloB4X/+yHMMvrpBuppwtY7Ml/n8q3t0AMRKJTBkyxJQzfHC
	 0tX46RWGBl7Bl3OV87yZZ+iGcYD7f6fBfA0GQTSieKz6O5eXIUSzNwkXcidwQJbejw3tw
	 PvjUXjvaReVRWWOAuYi9HrU8rFrcfTdg0KsME6XKPruzdItjBHzmMESo42NRXFw+yzUhW
	 1jk4q7fS2sWowhyCr6WzEw/WnBi/GTdViTOCOQwAqsueewcQvXqOZoBqVmDjwdTQ+sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIMQ7ych;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927D606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A927D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIMQ7ych
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so14177695e9.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793444924; x=1794049724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qn1VaOGofv/ujd8ZvwN7vtgFnr5O801uRmpZaOHHctg=;
        b=EIMQ7ycheZTgXQbRjcokmpZmK/CLPHtHH2SfHppIfhg2oKERKmSzR7izvPkjWhe74x
         JtC85StnC4zSC+HggZdELNK4281l1dAisngx+zfIAY6Qu+2H7ma1noI0MeSUNAh2dkWN
         tHXY0IBTqo3993BBJsPrPrHzwlvDcxMNJEc6bgMA4BOrQRLMTJwOVcBQ2y1fw/1Djr7W
         NdJklECyUwPZHY1sHxiqOfAG2Pu/6pi4TrfMLcYmj2qMObldWiiA/NrEcKR8pKUkdae1
         Qr3WBG91dtg2IhgBcP1taAgips5v+ROTywpFHCCvAAVR5jULGSVMpbySJVrfjBSSUQKw
         tEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793444924; x=1794049724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qn1VaOGofv/ujd8ZvwN7vtgFnr5O801uRmpZaOHHctg=;
        b=WLcYeTxSS7pjuP8ImBBjFas8D7QeVJr1Rz4IhzSYBuMc5LKXEDSk+PiiafotMOY8ja
         2gvkkbfcOoj8xrEvDH+1vXdMFh96lRanAzev3SFBi7+TcfJONyl3HNcWYefN+uLYvCWs
         uu7wzDHn0uQcFyH/BbIau3OAP137CqgwJBLlAQRjk+k79yfhbq16C5bbnj3NVh/yGork
         GWr8gdGb481iLkcga+3AX+ZWM8bD2cS5AyFTVAaNAiWOvuOyQ9tvuSmvxMMKgXRwYdcp
         BVYiT3hvCgjwNPWfE9gejT8koy5IzQYlRhr7D6h/nrGGGJO35IVzLC1TWALsQgQydU6T
         CvjQ==
X-Gm-Message-State: AFq9FYJMSfZeb2OAzUdkWGISaKUlKG9Rbl/YQIl38bLJUvDFN/9NocgN
	yqxbDhupvAjpZ8PjHAUZMSgSLZGc17RM+NdCvXM5dN5vmBY3w9s1EXsAZILGtJZXE8JMYg==
X-Gm-Gg: AYBFou0WF6gbvgVjuUHFwqgKFWMBOxd2jbXJNEQZfZvuzTbGkeFvcHXFNOhKKcYNZsu
	8K7gBpBp4KHuBLuxfBXibP5fNc//Agu3bBLHwuEsXDsf4bopn2Vg+PAEvYDSCvR2ExRzZr9D/bp
	NtlkxFYgMZDSR86s+EsK3bBeANzsyh2WgBk2RPk0diZweFfWu1LUIYOHFG/P0Rh01k9jZ/pDcm1
	ResCPTmBxu6N8RVl0YQvIDsXwq1/BA3c0nusHGNFB6RZAejlvQ1LzvTTKlRX/AksZivuoeliyJT
	Qgut9su/gJDTFzQOV8dcn3EH0qpQMBVyrBTDlkXYMPWZgxjX4k+J0xE8QzXhxfP4nHXiLyFYtQs
	QeRD/Gae8z4glisPQOpsapnvg+qenQ9sb12+/N+Fw7FZit4s5kqMLRw44a6ZyN1pzVLYXHcuLIr
	90NvWCs0BuDFoIMIdiuzBRaocNC0KH7v6mpthQXf0e8lN4StfyJzcJHDKB931uW+ss7Di/zRnTc
	oubK+i6K04n95SiyUGwEJveM072c8EyfMvDckxBuPoB7hNU5HeSZ5r0Uxg59mUMvApOxHjA9kji
	VmJgM4NffeewIdvaGk0mSmaAnKpcPIDq4+ZbxjVriincs94xzi/y4fMCP5oVBt+zSw==
X-Received: by 2002:a05:600c:138c:b0:4a1:f90d:6f4c with SMTP id 5b1f17b1804b1-4ac17ffaff2mr107425825e9.7.1793444923989;
        Sat, 31 Oct 2026 04:08:43 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b728f9sm8190774f8f.10.2026.10.31.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:08:43 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net 1/2] net: check the sendmsg LSM hook for every batched message
Date: Sat, 31 Oct 2026 13:08:40 +0200
Message-ID: <0b1a91e7fa0de128c6e2bd3ae2f5c960a5c0f883.1793444262.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sendmmsg() skips security_socket_sendmsg() when two consecutive
messages have the same explicit destination address. The comparison
does not account for the message size, so a BPF LSM policy that denies
large sends can be bypassed by placing an allowed message first.

Use __sock_sendmsg() for the cached-destination case as well, so that
every message undergoes the LSM check. Keep the remainder of the
address-caching logic unchanged in this minimal correction.

Fixes: 228e548e6020 ("net: Add sendmmsg socket system call")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 2e3b5737c481..c2a85224ab55 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2709,7 +2709,7 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 	    used_address->name_len == msg_sys->msg_namelen &&
 	    !memcmp(&used_address->name, msg_sys->msg_name,
 		    used_address->name_len)) {
-		err = sock_sendmsg_nosec(sock, msg_sys);
+		err = __sock_sendmsg(sock, msg_sys);
 		goto out_freectl;
 	}
 	err = __sock_sendmsg(sock, msg_sys);
-- 
2.43.0

