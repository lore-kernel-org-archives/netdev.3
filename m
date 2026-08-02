Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21831F98B
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673568; cv=none; b=DOivQ6q2u9yjqpzi6ZLtJqWbRdHCf205EciJJ0eGgHEN387reIq9g6+zzJXXge1M74j+OqXtK2Par3KjbU/lcPi2xyBdaQrC+u9l4eyCG96hT2kRzIJyus3qhkDaTm4goovrWrbE9cVB2UBZGnUCy/Uc2hmUubdXMC3BdTeK2Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673568; c=relaxed/simple;
	bh=78ZYqvTUpd1VXQSgBeeKPqpegdFffVi3FVPKNdy05O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uzg7q4UWUhYcrriPUWkOUCTYd4xYPQQfn4rtwYyNbZYdEHuTQZ2mdhhXTOIJMJeLlUdiQ6hGhiK4pqoID/Ye58l5VoG3q2SM+XgsFKI2SuYqtzda6mKBF+PDMpBQn03v26N3XLac9Dff7iXByNNOH4XFkedzzHdpAmtliRkvXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGgoRWfB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGgoRWfB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2127981a91.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785673567; x=1786278367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWvHCQCXwy8Ge5w8dAgMaJ75CYTy3Mf5Adif5spksHI=;
        b=AGgoRWfBqYgr4Py/JG782yz0yw5M7wUn4JoXNpRAwW0to/bSjMX+zbQucMQCFfMEyc
         4x3hbeuqCSW2ap50tLKa0eGG+UoCtwNmY9BneWhtx1a9d+RzJUgNaJRoFns/Voa9GTiF
         iD+yO8C7C5YgR8FacExZcCic2+14q9PTSkngblK1ecdnh635Znzl3naUysb/h/1g3AJw
         mTWNQlHgyrGKBYUM73gcPZWP0iHWNQ9QR5zgM3xmsAPM+IKs8aVWq56fEGayr+rgDzUn
         WZNjis4BU8szKUdtsSObNr7Gh40MvNFw8zvIgmSeuXfQCc6FzD56e3ms/X+mP4AAiPmF
         sZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785673567; x=1786278367;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWvHCQCXwy8Ge5w8dAgMaJ75CYTy3Mf5Adif5spksHI=;
        b=UZ3m1WGK2l5ffQDpf4QQZoIqgC/xNgYtVhDEAJThzO/7vinRy6CfTodTMrDJMzSYra
         KONv+fgY5PZJRfajjYtGKzNkFBxHwm8sMqW8lg9XJooEr1WjX2kEQujHqgNfBjz/whha
         x/KXoDt6LEboPXjkXwuYu+enK3rj2G/JvNZx+fMn/vMcpYiIWLhneES6LIufeQb2+/EA
         z4JjkWFw1cT/oweZpeFPROiPGIVZv1omrEVQWMRbiFGtI6PHkRAaosngazTrsIhR789k
         dMSj5E4Nrj/HowCVOTcrWSggHsD2r9zTnOdt1YOwXMm5xkgqBgbfManKZbhjhkz0H0eT
         mDgw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5IhYM9fplin54C3U4QZcWE1aWllU5m0wTGlPHUxRA/gT/kQCuly/4X9TB2Fm2JSkwrNlp5Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3VJ4AFs5GZHQK9bqEbS5QtITOQn55pdNEPJsamG/A47eIs0G
	u5u7kUM9kr5Rbc5OffRxhyo2liqcWe1MN8NESgftLtBsdNTTm69UzsE0SQVDYdyT9qM=
X-Gm-Gg: AR+sD13wXLyJoDfaYKMcVT9247m4lKNfOUAmrAcbVpE3Rct8u4U76ig9/WVHdLWSjhm
	XgH16UGsALOsjLFQWGOFp82OTZWcyC6eXVLcUm2a+En8YKtTzt3Y880aTxq0dNXvLv2ICAB8Yn4
	kU10Oqnn9wnLgeOEUQRs9+hK1BhdkG0crwMN7TQ0Ucu9OJZ+nRfDNkq/qvCAU20xJwyyCobK3x9
	IYwcwY0zrU2+F62nJ8YhTkmKgsuUuKBkEfgjJHD98KoFi0EjBpymb19cWTPB+tzk2t/2mFr3rtP
	9IrYaanngMDilw5t2PAd8AjD6BFFXq2G+iJJzXuNjgHyjxo7qy8MntNO76HUK4bUJuppkmZpu6Y
	/gWJ0HSZfvb08mq7k4qiD6q+c1Ld0Gk+uAr3BiM+e7KtF23ONLoRbUtHKeOJkj3t7bxjUbO49k3
	Y9TOAEvDaG0ZVzK2ZNzHUXcNVUXqJ2Q78bxySB5saAE+f4Wg9F3Uoq2qCjPJTaF9F1yM3yqcYZT
	kdabj+/Se4Lratmgp50yWqiL7v5A+WBPuKPuI2gTQBq3SPUce9ARI5SqZxFEYqIEFGhWrlxW77l
	UPwOCIU9kdqNTX1+6aRIDirfjmOxHD8=
X-Received: by 2002:a17:90b:4427:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-38fcaa28645mr2240337a91.17.1785673567028;
        Sun, 02 Aug 2026 05:26:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30a47b7sm2756566a91.11.2026.08.02.05.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:26:06 -0700 (PDT)
Message-ID: <1ca28022-bc61-423b-b001-477b2ed626ca@gmail.com>
Date: Sun, 2 Aug 2026 13:25:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 3/3] net: tcp: block standard payload injection
 into devmem skbs
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
 Bobby Eshleman <bobbyeshleman@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kaiyuan Zhang <kaiyuanz@google.com>,
 "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260801125308.1342897-1-almasrymina@google.com>
 <20260801125308.1342897-3-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260801125308.1342897-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 13:52, Mina Almasry wrote:
> Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
> page fragments to unreadable devmem skbs. Create a new segment instead.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

