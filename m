Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8939D6FC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096473; cv=none; b=kEouLCr16aH0eJsEJtYqOCZRJtyPzOgXbVUzByaBLuq97rcCb5BTcKDYWcM3DG1Ev6oIZFnnvZk6MnYLdlw7j/xutjuSD/Zonfs4s/XiqH3rRWoPJJJQXj5u9kVqFm9fU8NBIXPF8NASETFqS7bGWgDNxtniOYjQTR0Q4Zq8uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096473; c=relaxed/simple;
	bh=qQJNstfTwv8iNMFEAMGwgqeGoCJp+DtUVQAv7X3CIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrF1OqaaW9TwUDVWTTk8EkAeL8hDZtvmje7z8IWhfXETWGPMQuydEUO1vPBaJZFMTptD3F7sXhOAwfE1VUTDe6bW6m79+CrM3ahSTJldqWq5YDFkBCelOckXi5ayKBwAG05miLfiTOCoo2WdNlcyidD/pw18pgsseTUYG6A/2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=K5I068TP; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="K5I068TP"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c64so45727eaf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790096471; x=1790701271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9YLkzZ28C/6ZrOI8QJdDbKRDoNHJA/GmIfIJsBNLEU=;
        b=K5I068TPjV9liWWYwr3JJnaVOZUY+7NEnuaI5vHQI1YOo/tX9359vu+rUgb83158mX
         fiIxQnMdPanBMvVq7/ybZvzVRNNyp+t/f6e9Q+mw6oh/N+rS1VpvBqDXok/Vaqe26f8r
         5IjhwZ8FbChSAOVBb7b1FYDk62ruBclKtXIAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096471; x=1790701271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9YLkzZ28C/6ZrOI8QJdDbKRDoNHJA/GmIfIJsBNLEU=;
        b=BmxsTNlTMHfkoLtrrlvkKBSGF9tVHVOnY0fhoe+LdWBO0zWJ82vdnvNxaqJCjKFytM
         mI9F0PM3RAOBVNhW4SGPxfZ+tWtGTU1kIt1cs1u6uEeEZTxssm43pU82aY5w265L6YaZ
         dUsRdQVjA3uEu9G465ZA7ZWuxq31uAqbOAtADssqjWYw2RhqvPJUJYKn775VeuZAsr2Z
         7cbZhDYuPuv9sTq96WVts5A/KWMWik+bmSDxgnkm83rrj9x3+oyuh/9eHjNo76S7kgEa
         r6VFPAKRGa+nfaWO9u5mx3kFFRmXQlKEMLUWFmHxuo6TrwfRcdxpdx2B0X92S6sw3UKr
         wCOw==
X-Gm-Message-State: AFuF++m9VSqdHLGSDZ0QhVFf1+R5QoOUSDF04IrU2q3lUI5nObV6Y4Xu
	BqUOeW/aFfwdJFgYfRsG1CVS5BatLlHzOngCvmZACFZQRiqnhUsYsSVsBRsY8Iy4o1g=
X-Gm-Gg: AYBFou2bOlIVuWOhSH9NssPAHXHKni0Po0Q2ktfJuIGv7odGLnpWKgS6hzpGymLu//e
	YEdT/ib+ufs5MUWkBBlVCPWZStJw2PJlXE6LD1FdLmlrDzwcMWDOuoROVRmNfV8BZy/8Zx3jzCM
	De3bKQfN1cOdXSleolWT/80dleZOk0RMcbMNSlrLFy4TjFT0TJeEIsQZoZZDAjgfv8eENkTMO+7
	9O4gkEi6c6f8v7ncJKtFwfjcGD2YeiGyovQKSrkkODkALA8pteKMl8+g6NCkz91BflXHA8VZHlm
	XXhmrAxqd+uMPRMQ4UQzIvz/HFD3IyGJiVDw8C8kWCUoO4Aohw+/xYdjgX+0zFBg2essBnuQQcS
	BycR/WjANcNJtG2xN5LhVU74GZ8nVgMoLgSE6aagENWMlLeMgy0gxzUpfgwa6dtb2XTuOjGPtx/
	Pwi/EnuHRi7Te/EXuTuTwTnGL+3Rz+91gyJhIsKWtG4hpAzYgLwF8XPSwmUqUSPwIP9WTpb42hs
	jL8Z5dKlPcItABn8HKcYts3eC1opvh1269tbwjKAbZ2YLKIIa5j3X3Gv17lFlNF
X-Received: by 2002:a05:6820:619:b0:6be:b2e3:27e with SMTP id 006d021491bc7-6d2cff43388mr26252eaf.16.1790096470557;
        Tue, 22 Sep 2026 10:01:10 -0700 (PDT)
Received: from com-94485 ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2cfc4a98fsm35786eaf.15.2026.09.22.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:01:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:01:06 -0700
From: Jeff Jo <jeffjo@openai.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: check timestamp echo after an
 old ACK
Message-ID: <arK0UmX8qJy3O-rS@com-94485>
References: <20260921222609.50824-4-jeffjo@openai.com>
 <20260921222609.50824-6-jeffjo@openai.com>
 <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com>
 <arIE_i8Ysz5nOI2W@com-94485>
 <CANn89i+nY499TfuGMvMq3P=Pxw6vBxe+uYH1zioK=bhU--GXYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+nY499TfuGMvMq3P=Pxw6vBxe+uYH1zioK=bhU--GXYw@mail.gmail.com>

O Tue, Sep 22, 2026 at 10:09:42AM +0200, Eric Dumazet wrote:
> I saw you sent the packetdrill patch for formal inclusion.
> 
> Let's wait for it to be merged and our runners to be updated, as the
> kernel bug is minor.
> This will allow us to get a nicer packetdrill test that exposes the
> issue directly instead of via a workaround.
> 
> Thanks!

Sounds good, thank you!
