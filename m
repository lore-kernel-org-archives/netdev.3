Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313648;
	b=Vl/P57XgdpZ/UccU/130D0+nIaTMBHpqtDnITHx7dr8UnbSF1+XbobDF9HS3HKaCfjBz
	 WkUyBM9LxvIW+Nax9UUjDpMr6bI/2StkFhE0CtUMIkIPP9XUrNHOteZw56zbP20ypxrK9
	 /BBlxXsUI0WJ3+V7t7jV1qyXZBz+Xcb0mEuw0lVhESV6XOdQBjU1EpIGgoQqUsSSNiwdN
	 dTXrsHDhkdUZ7Effmwkm86MBogsb1a3t18KS2/HAs5euyUbLdwyDkeHuByOtUeHm1lwCQ
	 eY0TdxqUtz+WkhpaOCmu0qVO+KXZf+hEaWyvEhvcDp6saUN4kUKwgv12K5nDgxxEMYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=v26TLKrWvhVgWLQBFxdA5doS6zBCcx6klRRGMpDzDpQ=;
	b=Uucw05lbHpuaA5MqBDAGo6D0XX5U/F3zaErHC6kpnBN33GPmlTbclWj6mVaonhcEFYr/
	 PpVgM06vV9EzuMlPR4UmdB/KqmnGPT3H/SFsuq9UacoJu8WfyzrZodpedbmWmbhgofVu+
	 Cx4/4lxYfnQN62c9ZBzmamKRVKRj+fi5m883xf3tffxfMt5fnSr+FfIdI2eHTg8PIEhTx
	 jApXEiDBcl/G+k2v41h765X/3xXh/pbNjOP3/EySf8xhikqIKcvOjPMf+tSd3NkobATqH
	 KvKGi3RGDaT/+qFZt1Kp6NpTcwdbIsyHCBPuHa360YZC33UP78ErhnuH4ogdvDfLr5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066D606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 22:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7066D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so444405e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313642; x=1793918442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v26TLKrWvhVgWLQBFxdA5doS6zBCcx6klRRGMpDzDpQ=;
        b=HoGP2nR5HnnMREdHMmKLvXlJ8MTuqKsOFRx/lsPQVihkPjTkdxtrbcPTGdJogArE++
         gS1jk7/zpISKJW3LOSu+IC6Xr4H+IEO/h11hg+rnVy1EEoEvHdz2n1YGscTVT5IJltWa
         Zo7bmfcQDSNDoeC4p8dmRgYgYkMZOnHEIEvbY5fywv1NhzyId/5XGTosysU25Ku8Zzq9
         CuMgQAAwBDMwqaUVvbdHwYlvfNq/rGLbQlAz0RzGxv7dr0tyxyLckapmeBee79gdzeBJ
         Z7KwK2wybM5BJviJt2alV9iPY36Nx4LHT8LgdHLflIoiDZNACbWhvL4gH5IRJjeEsJ2D
         Zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313642; x=1793918442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v26TLKrWvhVgWLQBFxdA5doS6zBCcx6klRRGMpDzDpQ=;
        b=h3xdKokO6Pa3MQoXrAlfP7InDXvn0iptrpmcwNyGu6eqqALNcxiP2J/db3bYyXmb8q
         7snv0/0quAMyFjVOBP4QHEathQWI/AXzqgqfk77A1LKzjQkSspZDvQDXAcFAo89W7y6Y
         ZdigAxt8fCOUVAVY+yNx6QGRc10TKteruRWpRaQHBwo3Fr8RAzwjueAyWqwSjJVj14+Q
         BjOz1lDbo0lD3ZBz9y9RFPF8sMwfLOURSz65AbnT2xnJwF158rJHsGKvXpTGe/cnxyKv
         CIRo55of/l27C/Wx/feP8rqsX+liGA47OHg0l+4krOh+csuaamuLVTJJ7utd25d7CizH
         SE+A==
X-Forwarded-Encrypted: i=1; AKwUvBxWERy3K4ve3XFs3JFgM5myHnYCrcyBsQ2T9C9nCwuehs2kzLbbbRW+HtWuCIAl8okm8EJqHQQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJez5SW1hM4lERHPuGcdxiKo4ARWfRy+CNKeVyT7x6FZc2kYcrU
	ZKqjcQtpXqmwQh2Pcs7Tjyhp4orIbmBdlowfMg1VV2TRi4Ol6BhjJYro
X-Gm-Gg: AYBFou3wWsyQRTbTQQ+X/lHY5jjjdPIsL2DQcEZfmLZPeG6YuvXqj8qbBnqZTozflEs
	6foE/cacrRxbMAKfSiR0BhRBAaqXhSOWrNsbCc+ysS+eBlFsuuPWXe97hUEisWroNq1Q+wl/u1/
	ieI+OizeWz8a9S8R26T6cMe2AgXqtNWWlXLF5X51f0XArnSPi+Iw2ZPhvZEH1XieYzS+bbNQnCc
	kh7dbvbcrrPPlNkqIyTE8AXn0xqJVH2ncprBWFKTIALh5MpTfrwrmKJ5kQ6TsXyjy+0ZU1molPr
	lA/qHhSS1dzbwPMBS35vYUdYOb21quXQhJI0WAf786bPqjl6tEwk8VvP/PdMgcu8qlQ4UGTokLW
	ZHwTWdxk2ZjPwsNoQkITY2ZfTX6gRZvPH1nVvb8hQh2HvxRm434ejsev1B7/uMW6NBceNsBwQTd
	h680C19B+ZTp9H+hBhr5lwx2TBa7wS7p/lEOUW/SXwPl12aNHKO9GzxEDFQc/7hV12bwpQfC+KE
	ipjVsTkqdbfgaKhkxVK0cLapKvZNZ93B5QwwWsubfPgkOCGG9RqqigbhDfPIntgG76dqWk55oEB
	OffxafEUZIaCL2c7PqYwMyuDoffj2/pfgG7sW6I=
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4ac1228978cmr8730515e9.0.1793313641519;
        Thu, 29 Oct 2026 15:40:41 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm91144645e9.15.2026.10.29.15.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 15:40:41 -0700 (PDT)
Message-ID: <14736869-57ed-43df-986b-8b24ea9772dc@gmail.com>
Date: Fri, 30 Oct 2026 01:40:39 +0300
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: reject port addition and clean up ports
 after a failed reload
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abini <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261029145844.231018-1-omermetekaya0@gmail.com>
 <CAHS8izORg8OR8TyWBHmZsgFBtM3+qh7gXCJxifk1QGs13Q=ygw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <CAHS8izORg8OR8TyWBHmZsgFBtM3+qh7gXCJxifk1QGs13Q=ygw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



> 
> net and CC stable for a netdev sim bug is extremely overkill. move to
> net-next with the AI-review comments fixed, if any. Thanks!
> 
Ah right, I thought I should put every bugfix to net. Thank you for
informing me.

Thanks!
Ömer
