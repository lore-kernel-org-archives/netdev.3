Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967266;
	b=MttEq7CdffinnMMcL7AdzkZQKrGMfLXajjhKadEUZuRjDU08U2bVHOLm2652na5PrCKG
	 uCYy/htqRb7Jx3G/8+A4HNo4m5+yiMvwr5EhpqUMVhFsQiil7ibKxGfjGUsMBHLioA9Om
	 RXebaqIkcqm25rv3AaTde1YBOmLl8kkpAjmFu1GPcWTiRTVJmCRYdDRi7lQUp1YpAj025
	 m8bIKbW1KOFrIRRVeoflYFyb57LTq3M3dJ3V2LEnqZfM/W6pb0HRFQ0kYVyeEvYYH5tM1
	 eu0O9CI2SzV7EoAqbshAz8FXQoZNKnzv+QAl4p3RJdxGQqxVNkn8f5h9Ej7WbjRN/rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
	b=zwKZO5OYo6Mu6lJ13nPt8OJ6KfBqEFke62BSecLAHnBS8v+NGk5rPeOr0oTfj6W6GlhI
	 o8CiIJan6A9RcJnhrPqfxS7lwA1ymHR2Qg9N4RaRLSUeqZABEYGFFtmBGQvRf6b7hGhLT
	 c1WFLoZYb6hTTN5M/R5EPUYvQPKJPzqB5e8roFQzfWv19yX4PzAoylM8RhjH1t0aL2NeI
	 +egS0d15AYfAbZ5d/uGlgeovnn33ZYKim52TMwAjTxKo8PMrrpIeE6xuRndx/kHF04sTr
	 yuMHE+rcmU98tAY81O+2AgLDdFcdZH+F9bAd4LGaLRZt1Ff7pt2FkRocAfzr+3XYEkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a4JU4jom;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8C606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a4JU4jom
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a210470b49so19004075e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967265; x=1793572065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=a4JU4jomKA60PUj7LOJEy/pmftUjnoLJg/Wg0eRB2TZL21uAafWunkF0EpPI7jtX7w
         ZLUmHBJMdrtAp4mX0pXfmjBP9UI5oHNY4NNXdI8DIEprXaD5kIslOItR+lV7EYAc7Jj5
         2Pf/UtjXIFyvNbDA53BrD5GlXNk2No/dxodNYHBYbgCX+b2x75CzWD7mjjGKaIqhXcdx
         Hb6V8HK2ujH2wRlS9IPdsfPOm6qFIkf/jetRiB+55S6tCxt/yLa2+fqtteIrBr43jIZg
         kOsw1IbNiyU0pnHY0zXyJk7F12TZ2ZpRzMJo36vVMedf/8AUufUblKQcSsZQ0ccpCF05
         u3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967265; x=1793572065;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=JttnrQ6vAaB7AhXDPCpAtAhwxygu5KkLTSqs3PX0zXlG8dlkud/cBMptrSq3pHau33
         NPVJUxd3gi8gNYE3LR2WjapeCo7BesrEqNmc1FeRYl70VKvSlQ3qLGAA5RMFM45Xu7nB
         I3Wq2EUlhqKhIY6Zq5RiGvwXv5UfiMGjpdFn7OyvyBNglaOZSmIQ7J2CBJyc7tcp4MOb
         zYEcglS5/Be+FwE3EMvz1ljwyEgcF55x6Pb+Qm74iLDVgHL7JruWSDSEPZ1CYJTICKlf
         VYwExJ+D+A5L3ZXNdj+n5I0u37h070bzx4PCbebKcN++jlTHuy4y7UtzrJ1pJ0FIHNLQ
         f/9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxDm0FC9zGbigZ0x1bulPtPqR2oUctwLgSXroCwUHeguq9OAm74D6PRSgy2xS1buSa9RMMCl6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn0eCmsi0/cruFgGsNvn1lpwlhOuYWMi2c1y1Zyvay3k/6HfYq
	uu6cBbxl8DgBcmiEdFOrqENmQdkASXQ+jiQlrKYCZ+hVu/y+hhLQ5rw=
X-Gm-Gg: AYBFou2Thm/Cgz9n0HWYBSaEBDxpDi/mufIFcvCD0fRDmcVf6gw87o84JWbwQ395Tr5
	gnOA039chtvE1yrijjQXFJDe7AgLdCnhcb4lX70YOuZahAs4jdK4dDMGy2Mt2328ctUZKFy9jCq
	iOk3whlVeeC+cSGVITwR2oTidapfNN7H2Lk4z8ODaleXL+C30NYe76J2NojRA8oKzUyilwMjDDv
	RSFqUtWmKBCGz0fjVbxThC17JS0lKNCWf8+vnjnURIRnMdBeFjIFOwZkjwBpsdez5QPyhER9ayd
	L2GyUlpgqJsfitgzBKhyHJHI5Y6lOTZLQO5ksAjiVD5U+3N79Grh++Mvo9o1kmmR2RhudtzMhV7
	7ejESWVCWCnjq3u00LB4pOpi6sYrfdDYa9UoGnXTKBy306d+SJUMgMaTe48koBffsY0oPNFEt2i
	r9umKiAspu4U4s11kOdOxWW7N2iiyjJcnZtczVSGHQE3tN3fF36bj18j9eBD4joy01m3SUz7D5O
	rjrP4s9tmAAfpUVX5ZhJOnGnvz3PcL+Ip5qYg==
X-Received: by 2002:a05:600c:a45:b0:4a1:e11f:b2e1 with SMTP id 5b1f17b1804b1-4a35aca4bbbmr98354425e9.15.1792967264894;
        Sun, 25 Oct 2026 15:27:44 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm401391845e9.1.2026.10.25.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:27:44 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linville@tuxdriver.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Sun, 25 Oct 2026 22:27:43 +0000
Message-ID: <20261025222743.1092003-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278531637.3327.11947058101101849130@kernel.org>
References: <179278531637.3327.11947058101101849130@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing timer lifecycle
patterns in the NFC LLCP subsystem.  The issue is theoretical --
found by reading the source, not triggered in production.
