Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633525F7B9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975198; cv=pass; b=kjybajN+NXeFQbGWkmEvtu+S9kBfs65Y4GQ4nmUE355pRnoQBJSeJaN8ObKW+cD8C2zwqOPT9m1TS2EeXjGqnKvrHHf57U7Ad3vdHPIxCT6sKV+Qlj3CMjg0eOPe969NyLR6a8c16CilH/eUVxbnDRFT7Tc210T5dfYtpIsjSYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975198; c=relaxed/simple;
	bh=KriQnSXnAfbc4b7HoAoySuS9Bfa9SnKi2FUyGbxqivI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvOYbnSufP9QDCI2XHD+GK8C4QGh1/sfRA5dNP+W8hdi2bNU5j3fR1WzhliGtdlfLWwcpCbHzWIlOqdmv0aGTm+01n4gZC8MPHer7Jg9Etrw1CXegzVqveBybD+RTWeS7H1hX6gLRWi5ySUykpEGz9TxN+5hvB9C1UdDvEjuScw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj3ywh9d; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj3ywh9d"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2a4e013a44so24319266b.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 14:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790975195; cv=none;
        d=google.com; s=arc-20260327;
        b=ma1ZZMHphQj5CQmo2fHV/U5FmsVLx55AhbMBFbtlwimBYlrucX8lV7zR6JlTUbMmsg
         +n2CkaceIvF+ZYOyRUhw6v5LB3zyYP+tr8pMr09gFhcpkOJRgif8GwrxZrzlfgCVzBCD
         aQD7UkDD/pFXSXrAqzPhNah65hVWQGOWvFSZRWeLaEanPXI6AraKR+ytlj6IHT9u+D6G
         dwl6Rqynyt+si4sPa/gES0oZZhzuJaswAQ4oYqPP/jjrXVRt99ecuLKUQxtzWFLGX2ww
         G97e8A6uXU8lpJuY5sKqsyvtBgtTE0+5VeOpsejjtTOcBGPS9d6ajm3K4dmaf5glwU6Y
         EQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KriQnSXnAfbc4b7HoAoySuS9Bfa9SnKi2FUyGbxqivI=;
        fh=W69D4jmmQ67trk6ULD2YrwDCi4PBblzXCgXEF20z5C8=;
        b=kQgTbG/7fF9/sAAnbf+6xkFMk+kTvn/OtugaY+phoY6uz6Gmckc9YHdjEDeNNwPcbb
         eqWTWVwMJ7KCYPrp1ChVwtt8sOAaNtGQLZgZKVczcGfcItBiqxx25Xy4LhHprJc6SQrg
         pq6RPCmlNRiX6us8EBatmDxr+dfP2YOzjTwQB7tbaGjVldGLKO5CN94+8NuqdZNI7YLQ
         kTbZbk0KQq9/ZVXR3GK9/3bi5mA/smsPoF2InWb5QKBbNGphLdVVMd2JtNyucPLF0qNn
         EIN5Rfff29z9DlzWrBaeCb/ET5izCRPSFd22frAsmna3MPh4WBKOVfnm6g3cEuoXGlOq
         7TAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790975195; x=1791579995; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KriQnSXnAfbc4b7HoAoySuS9Bfa9SnKi2FUyGbxqivI=;
        b=Zj3ywh9dYdCqNTzrmIPS3Mjdn/6K6e50tLx9z0gtQKVY+d0jorD+lDJEHinVyEh6Eh
         c6f5aGI+GWsAfA0obELxcpgnom0ETbz9ru+RZRIAqDNggVAhehoZjbFjawddBqPy7xx+
         StxfXT2S7SQ8Z+RjBmdrFioceRBYk5iINjGOyam8m6kbUu0xJrNp8K9qpqv0XltCAdLM
         t7KOS2TaFQaCXdtLuwIv//bX3F+6ETtswdLpj9j9RNpqjjBPEbu1MtHjdRKuSLYs+951
         GMx/xPSQmR9iC9GTOye5v4vN2YDNZ+KiGrOGVVy7giTcwjZFmLzi7/Y8YN4XVQQajAjn
         CoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975195; x=1791579995;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KriQnSXnAfbc4b7HoAoySuS9Bfa9SnKi2FUyGbxqivI=;
        b=bVux3yCkr0l121uId2MhujqbLlmbnER+mVzVJp1kgkCmMow31FXHwjZD9ckETQuvmk
         hDW/MnAJRIYNUgQB7bYubBRYZ6+X3qmNzL358UtNFoUA3ItINMDaXLEU2s72LMdffcMs
         NLgzMj9AEIOgthC6dny7WivYUK/YBlsTpr97iSeehJJE/kf/e6HlxDqTyRghBLnt3BLV
         AOFOp8j0PshiGPsNZs+X+6pozQ8lu9IPbTuz0/OD5iewgZIAV0C2341NePbkaEU93sGW
         0iB39NEP6ImYI3NpQgKFWx1uyXzqzTFTfRN8UdaTmuNJhIEcjzSJv0eGUQSa22Fjyuzb
         LjEw==
X-Forwarded-Encrypted: i=1; AKwUvBwFElUHAJfgcCjXYFG6rGiwJ6ibvTt5KGGLsX99xPXveOV+K/wDJmANWmtZx/KcWhr9G3TUjjA=@vger.kernel.org
X-Gm-Message-State: AFuF++nV4ik7SiKFptv8ruZsSAE+V7vzkHIdY4tkQ1/il7IrJi5eYg/w
	kL9ZBk3QpFDSi9Mba9oG89nXta34x/lWTUOtpOETJ0GnBh9BPor/oafqD6n6jhA31Edr8f/i+L4
	VQXO8dsxtkSUfFGJ+ZQB4eI/PoVJkBNQ=
X-Gm-Gg: AYBFou1hnPcRN+Yn6FyrKaymEpCl00EQBvRiSLhR15TKJjIGYYJQoKE7BfF/Im9DfAz
	XPkTnct+dsFhRY8U1lwY+2Uu2tkJg74iF/TfLZEndfMN2LF9ajmoGfEqhi3VaClVj2ChkXaTuC8
	1O5LgOPxmuvI7HcpBnEJP/nqH75PXIW3TsmfgDLQCqk7ESJtEhA5RZwLXbAUq9JbXvWVA1TpiLW
	rW53/7FZJvXxnZD5LoS6g9l22EzK5bwkU957AuhVoUyTtn4meShmXpV3UP/8ef9hdCmk5fBE7Ds
	PD/r51t/+2SxPHXEWklIqQYAgwwb6+svS4DgQFQhNnAPSFuwbOwzMiM=
X-Received: by 2002:a17:907:2d13:b0:c26:306f:289b with SMTP id
 a640c23a62f3a-c2e6eddc46fmr33676466b.13.1790975195137; Fri, 02 Oct 2026
 14:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <3c736ba6-d2b5-450d-bf9a-c104cb818f1b@intel.com> <20261002133932.0b2b0776@kernel.org>
 <IA3PR05MB220784D3846E12367B0CA1D3738B892@IA3PR05MB220784.namprd05.prod.outlook.com>
 <CANm61jco98RoBmBAtbnjRZCPwqS0Vt6SqXjYAEUwSD4-bWLuZA@mail.gmail.com>
In-Reply-To: <CANm61jco98RoBmBAtbnjRZCPwqS0Vt6SqXjYAEUwSD4-bWLuZA@mail.gmail.com>
From: David Butler <croepha@gmail.com>
Date: Fri, 2 Oct 2026 16:06:23 -0500
X-Gm-Features: AclHuK8-PGE7GR0gO_Ls1xmhj8X4iGncreTnOKCvfkrsYn3JfK0aJSdmnsZjeXM
Message-ID: <CANm61jdyUb1HvpppSk6jkqALqPv7uunvh8KWvc=iJuTh=9=1Pg@mail.gmail.com>
Subject: Re: Fw: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
To: Jakub Kicinski <kuba@kernel.org>, anthony.l.nguyen@intel.com
Cc: Dave Butler <david.butler@appgate.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn, 
	bryan.fraschetti@canonical.com, tristan@talencesecurity.com, 
	tomasz.lichwala@linux.intel.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

> I'm not touching 6 since Dave's response has the confidentiality clause.
Apologies, I don't know how to disable it.

(Also, apologies again, as last attempt contained HTML)

I will resend my review response for 6 from my personal email (this)
