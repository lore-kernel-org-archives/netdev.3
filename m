Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085433;
	b=eVgY+TJtzNxddm21Csh/d9WvyfZJJRujKMLDBncH6w58szpmaN7EdSdmcJLCQzcq1b7H
	 eBgOY0cJWVyyFr4ByTjlenXYLgrakbfEHMVt94cV4BjWDX8hzMXOXASQwHZD4l42EXEHc
	 4e22wTsfrbqanea7JQ9pnmIrJ7JRsjtT5pG7t5AVYtJUUZUjPUNSQYxCqX9zITTGavga4
	 rBrUW5xmC1aNTU1h0LMgd+Pyjqi+VacuL+vbZZLf0b6KV7Ax9K8wVP95jpvH4oq26GOuy
	 c5f3O3j5P5/gReLa7Zoc62kIhTBDvRBu1bjUjHa5tWKHVVVvdNZmCfftE/dA8VzyNJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6ZaKA9uotmuigUO+lt3+1p4XtUC0uLUC5fl9/GAlSTE=;
	b=ct+JGUFYZoJm88ebMM2gQrOW7cROanjlb3JFHlnIwf3AqNWjACj/RKzaNUvEsNMTZgrn
	 8fH+DWSwfVokiee7j9bnqPOhyehKbFFYc1pIC1knQ9IYiNDzY8agg6OTvoS9yHs+A29ki
	 wirtpmvYHK+nyjvbrHKOfNC0wRBxZM7dBE2DFvgYkmw+g2taDi4tzC3SUyBYOxmrQjMra
	 20vyNVCon4SZJfjPlrFAm27pOEbrwCVOpO9vQi0PtsOL06brFloHE3XVAxfJdZIWwzobI
	 QpQNpuGtMCv8LStaYaP+EDvegMS4Pi0YGKPRFjVvDwCAY+33Gw7Xy62lBBUVdOjNoog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYkTBDCt;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF2606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 21:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ABF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DYkTBDCt
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36ff9c9da34so75352eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794085432; x=1794690232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZaKA9uotmuigUO+lt3+1p4XtUC0uLUC5fl9/GAlSTE=;
        b=DYkTBDCtMVKNjelCFUqz9yBXZcsxD5nKLsWCMfrAht//WWfHMadqiVfjcBRm1HLV1l
         WZmjcIkYk4aZvv/mfH3IaF6qqDliqGSacqrEn2aQ3H0cFZ+qFy1RUtm8jE71xfNEJFYM
         VsWaq4PQrJ26W2HLPK2HVEmxNPINLdjGHajOSJkovmx18gOAP62NMQqc/+lALT1FQvhS
         or7wQpJ+eyuoU75gp4ddVR9k62C840YtCzZZrODYeWcU43EPdSlBjXQfLrOqZZpjaF0U
         o5r/XhjrHbw4SA1RnVAn9YwRIw1/AZ/LkQFqhmIsBaeIzSPbEh5Wr0a79dLAkLwbIzuK
         uCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794085432; x=1794690232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZaKA9uotmuigUO+lt3+1p4XtUC0uLUC5fl9/GAlSTE=;
        b=eiDXpwBKGAATGFqAsc1MPfkf92iY0oRUX+4GA2HT/IOds7u2apg156xo6NLBJSX+yo
         kXHh/ZIxLmU+5eGbbyAqb2/lLGdzekiEz74gCuwGJHO+7KqmAXxfeRstEDllemyTHM/Q
         axU9A9SiE+kCuvniUXWfTszw+KCBk2ksyc2cg7M7DZvBAXqLmKtkvaguNIJVwMrua0mF
         yngM6WE/P6wTTm5SN/F1vvR0FleHYkMs8AGqe+Vpfgf7U+/UV0UrT7d/RW+rOL/Z76ol
         cqLtHTzvqyJYT7ghqEr2gnClF4sGFi0Zh5Ka0MdoFoWw0XyR7sTVudjeFDmPa0KmXYLA
         lzZw==
X-Gm-Message-State: APuU4Z9XtdPfLkzTcH7yoxg/QGsCRNEC447zQT08X0uldJoV5WmnMCj/
	/Ambd+gmoA3rAd0L1/u+exuVPvoIIeiWuuAUliuidck3BGB+suHlD2EY
X-Gm-Gg: AYBFou2B+WqlNthSH7w2KzPpGwSW67IfY9xEanNsYPzLrijEEnA55BeWqeaks+wRZNQ
	H7p8LxmObL7UAm5R1DccwfqOpIDfWBAc0wY4YWsTgjMCtEbplFQ0w9NKMRyQiJuwpJJRHZPmHQW
	qPJZUk6V1yJ68zFfEioWXTAdkCL+clneK4F8h2RkQu3PgqvxiSWlckXfJzrMKb+Iw1N4TxMm9n8
	myXA3p2vDVbVX/qRIfOZa0ChUxW35vn5ZzkUj2i9QUsjiIgd0E40jIljrv8InDOTSM6oADttxrA
	kd255K25+Zvd4bXSaakszJWIf3Daj4HbVE1Z711ca209NNeuogNVIGIWAh5J5tSJ9AIA25Cx/jE
	eJuhchUIxL4k81k64ME/VQvadUdJh0IR857aRXbl0D4igP8LQy3uJbBdmh9XbUILE4ma8JGNAkg
	7xMkJ9Y8I8yz3bpFQuuF/O2jcuxajTkO3uORDySL7nIp4F5nJm2TNiqJEZ4SAGWs6iC3qfb6tH5
	tNRy1BP7GXKpXT0mx8Lyr0q/tmBjBTFA8dCqyIW7Jwp2EzK09qYTIE/KGpJStkpxd35KOaC4Ue/
	vXERJc7hbocUTK+uXMDjCkIKRu1g1yvnDtSNRp47tyNreRgV6PM=
X-Received: by 2002:a05:7301:f29:b0:36e:b3e6:ebe7 with SMTP id 5a478bee46e88-37256bf3a85mr367782eec.26.1794085431966;
        Sat, 07 Nov 2026 13:03:51 -0800 (PST)
Received: from ZephyrLabServer.internal ([165.162.64.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f444csm351114eec.19.2026.11.07.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 13:03:51 -0800 (PST)
From: John Macias <dencity7@gmail.com>
To: pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: clear the conduit RX queue on receive
Date: Sat,  7 Nov 2026 13:03:15 -0800
Message-ID: <20261107210315.2003645-1-dencity7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <15433a8b-5e5d-44dd-a12f-f2074857c1ad@redhat.com>
References: <15433a8b-5e5d-44dd-a12f-f2074857c1ad@redhat.com>
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

On 11/2/26 16:47, Paolo Abeni wrote:
> The diff is damaged. Please fix your setup and re-submit.

Sorry about that. My mail setup re-wrapped the diff. I've sent v3
with git send-email, with no code changes.

John
