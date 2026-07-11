Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174F385D60
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761768; cv=none; b=aKgcoXqF8/VV+E1LHLtIyFAYe9yDhW8A1J7JYdgpWBYz9xtrQsb7PbJNKx9/H3nXL/SRFILW13EYGc7cPJZAYE+2FvDcHwGyhjsNN3kOCF17R9RPjTylr5EMAmBUAhrhOGb/+pQl933XYppJX1b4PXa57TlX6rsx27M/PPrCxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761768; c=relaxed/simple;
	bh=P6EalHP9+BROphJZ27YayPMaRYCunePC8pUzelEWcIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg8T0jCtc19S8bMt0eAeBEbY+Owmw3JOBe4G7sm0oVTWMqdea2jSQ8glj3ufaKv8BpCmIxw4U22HY3x/sjsIb9h9d+cFaHU/Uy577y3WkiQhNj4HlZ/WjRP8R4jTLMagowg7+7peGtPehDH/6RzlGJbyQtJb8gN6XMNO5yBIogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpG0rXil; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpG0rXil"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so2813579a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761766; x=1784366566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvyvBidIg+3UrKO0u6pDrezQDrSqlxgzpFXwZxQCFac=;
        b=gpG0rXilDjxE4Z90a61dX4dzncmj5g+teX6xBtShMMzpLlsaXk9wHwHH7+GbczTRg2
         8ykusdD0MMrxenLqIWcwr67oxuGMpg7QFSblPfu1N6A7Xhj1Lv+wTJfjTToIwX/FIX1z
         GExjWcIBXM72Fju0/FDs46DJaeIlgverGHEcVTE0SyQBcwlJsZlfz2jpb+eyPRtqJNCF
         8vDbhVBrvox9QcuauT2b9OO5dSFCWAfOH+1ME3eWSdv1ZRnj3Dnaw9mNHdU+yjriVYow
         DApgUNgBTkAbxWzwbFYIsexiCWn19X5a/oIUGp9zsRm3J+SBmhQkRNmLjEY/dFVHVV2k
         dnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761766; x=1784366566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvyvBidIg+3UrKO0u6pDrezQDrSqlxgzpFXwZxQCFac=;
        b=rluEkqeViuiLq/g3H9dO7Kb8l/bQQnKjPqWJCNTiGQLQHl9TQAK5i0yhV+dgAk2okh
         /lUQlv4yxeozoVLQGNL1SM77I+WRrYAt03kpqVf40Fhv6nFKTGHI6y5sHplohNk+BS+g
         ZaphsewIHxnVWqmSY73fIbbiQ0rCLc1bImBWazA9JiMSETN8gGd8dOizswrYQl0YqTG5
         RZWie0MrW6RwRwYQhxrqRTIldOHtcUMQvZ/Pd+o1Gg5redT7kPkoEs1sSfxT2l/10+iR
         J/j61KlC0KPqLAeRl5XI/0lO18QT+VndtnOgI/989QtMFnFoo9stvRX1kUZ2E0cVUAu1
         W0Nw==
X-Forwarded-Encrypted: i=1; AHgh+RpGRYxqMvsljzaLlK8+o4oEeZK3/CrXuo6YYp4IWt+4P2wtz7gl5xRGv/znrBncBVxgZKBwY3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsrjrfQnTGQoW67gkpImUdqAxeMM7KGxp3/5p1MFHzd0Ua8JE
	NVuXs+50uBQWIYT43hE3CuixqxlGzMzNPu5GCRGYP9k+osX+2P2ipvKX
X-Gm-Gg: AfdE7cln0Ycski0M0Ejt8gn+Dac2xL8CadCBfYISwQWhqb1EuY2sqPlHm2c19rhKPME
	mKLE2tvJi7eTK7vpwCtnNtxeDC4I0EQvQOCBK2RjomHhzhSBYjPLpmIJ7+FJPVyVSU7gdK2Cvao
	3UaQdcGyhz/40WDJ3EQ3+lqHh7d/GsWvJ9lDCu6Q4RajgwuCSXo/ur9KipHgO2p3jAGE8Mr/BJL
	XX08vP05Udwy2yiSNIplSxybDP3PhvffBIKKW9emgO9c9ESnKl10HcDw6DudUdv3JO3xDteHBQP
	8XrjyxyxWsT78c/riVGely+MjZOeB1j8oVL52JqehAJ3pd+YmkdlPjw0tJoFvmyomkeDNsnb758
	f/V7p7Gos8jOHzdtbjTSWKOQco35GuBj4h8NYEyITxovF90hJeYSFHS3k+Sx297HnC5/i/JMp78
	87gHwiTFtu7fRZwJ1x4nO11I4vwWHjPbWUuiRMGwlQptQRZzAxDDIL3Qu43B7izy7Ggyrs6dGKO
	FDXBBy8G8PAjxd/6Yry/p6TiG0VSn16LIWHxl6txosdDxg=
X-Received: by 2002:a17:907:f497:b0:c15:e07a:eb4b with SMTP id a640c23a62f3a-c161e958ae5mr77326966b.3.1783761765333;
        Sat, 11 Jul 2026 02:22:45 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:22:44 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 2/9] net: add provider specific net_iov field
Date: Sat, 11 Jul 2026 10:22:12 +0100
Message-ID: <f610bd27092b068f2141c2687cb51b6a1e959a1f.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783619193.git.asml.silence@gmail.com>
References: <cover.1783619193.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a hole in struct net_iov to give some extra space to memory
providers like zcrx. Keeping some extra info in net_iov itself helps
with cache utilisation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index bccacd21b6c3..a564c510b484 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -95,6 +95,7 @@ enum net_iov_type {
 struct net_iov {
 	struct netmem_desc desc;
 	enum net_iov_type type;
+	unsigned int mp_private;
 	struct net_iov_area *owner;
 };
 
-- 
2.54.0

