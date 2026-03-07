Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FA2C158E
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772885171; cv=none; b=ZuBxDD2EyV1sGL9lz33atI6r4HWB7YpbzpEjvA6Or1vwQfsbV+fPgTBHAns0UtYOunG4YjsqPS5nCeyYIAG+deTmTq56+3XdnF8PhOSbWfEcZHRZkFcuhgOlpiklhueDuaX+hpHMQCNkUApv+Wa2kaqbu6aocp088VwICKfRZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772885171; c=relaxed/simple;
	bh=6oGy/hX3Nt6CN2Ur+c0FUQ6Ms01HxGHW1wm45IQc3pU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ovt6XbtY5OuOdlMVQ1D0UbyGCeUIktIcSFRlJpnVvSfQTzW44c/dlNWIt8UN0nmCO8NaA4Jk4JJ/5tZa2BELXB7bYAlP2DKiU7Tt8V5LH22z0wl+AegfMsZxsohHLZYAzz3I4N1peZuk5yCYAzqyFR6G4/88Kz2VyfACOwWli7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqlPU/K2; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqlPU/K2"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506a07740bdso321779191cf.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 04:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772885169; x=1773489969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/9pYeb+arx40oYN4KNXymAnF8wN378GYf6XSCYdq+hU=;
        b=QqlPU/K2p3vEvLbGE5LlX1a1RROCb3FTa48QUWHqxw031C1AZ6vospmtBeePARysst
         zqM+8/IKf6M7N/mo/Ckm5jjTZ1lLzTrGAq+ZK6328KtY8GZE7m24EfnToB6slCkNv2hg
         CPprY6sVuFkEjtLynk6ekQN4xvnZPFSom4tdzuFIdUgSLTqMIDMSClA3z2QhcUGpgWBY
         5NugzuXrI8zttKGgntO5M0lyh0yCfCy4y1MGc+uniZ9d50Z7O+ITP90Zz0GrHRvaqEDL
         utLhqvDJZ5cA3edUjdXNY2p/DI5tQRUS077afSabZoJdYJnhNvjjacXQW2ZladRCDCYr
         H2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772885169; x=1773489969;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9pYeb+arx40oYN4KNXymAnF8wN378GYf6XSCYdq+hU=;
        b=CFRjzB7f8EMFeFT15tT8pKIbhprBl0pjiO5e78GLRavymu6Q8RMpgr7RoBY3abz3to
         2gTMnAWj5U6qCEf3+Spzmfn9Ifpfcyiu6CuPliBshTo6zpmh9GcwkBU7Lvek3zcJOAZ4
         Jggk1Xx+C+/t/MnLkWACOKYecN4lRYzLINgCpWL1ApK1F4ycjzNC4/P7ZnTCDbCFjQyH
         EWjtsQ8fOHk6fNXct48wet7e+nSjHfyNwUzIiyvGfc+4/XGrJoE2RKrxw8fQwP7Q6q8V
         r/rPLT+hFJTcX/G5QMoPM0AtW0AilpchjcQzUlRMcGPKfNradU9gySrmYY8HZAFpXKFt
         f6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsKtLT3tJIYkPLFr7fa8qUS4R1CtqvWorucGhs8PbEmUVTKooBZPQzumX3Y9PdEYC+LaaowJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzrz8RTMZGBXy7+UwtoBkJsjGla/Epvo3h6tSlbI8SKxxsU6Uz
	GNz1/z1ZZ9pEjILYZjrBjOuX6RqcL+tHXUwkPj2cj5/jlIN19exVLfE5XbAPQDFpp5tIqujxZRD
	cd72OtT7xbn4bPQ==
X-Received: from qtot26.prod.google.com ([2002:ac8:65da:0:b0:508:fe4c:e5ba])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a86:b0:509:d0a:564d with SMTP id d75a77b69052e-5090d0a6076mr1762181cf.54.1772885168633;
 Sat, 07 Mar 2026 04:06:08 -0800 (PST)
Date: Sat,  7 Mar 2026 12:06:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307120607.3504191-1-edumazet@google.com>
Subject: [PATCH net-next] MAINTAINERS: include/net/tc_wrapper.h belongs to TC subsystem
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

include/net/tc_wrapper.h changes should be reviewed by TC maintainers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b277d5bf3d1247544a2871b794b578c5675cdfb..6175c34910269fe6d1d20cbfb0985e25ab72fc5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25751,6 +25751,7 @@ F:	include/net/pkt_cls.h
 F:	include/net/pkt_sched.h
 F:	include/net/sch_priv.h
 F:	include/net/tc_act/
+F:	include/net/tc_wrapper.h
 F:	include/uapi/linux/pkt_cls.h
 F:	include/uapi/linux/pkt_sched.h
 F:	include/uapi/linux/tc_act/
-- 
2.53.0.473.g4a7958ca14-goog

