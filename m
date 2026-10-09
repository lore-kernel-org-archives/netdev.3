Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6F2773E5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512847; cv=none; b=l6vnoMsYb89Fuk1Bnf054nfTEInStNcT9JmDlTRpG2vBkHq9Yjk4PA5EeWGKvLA+5jbhlz+AZrXB/+e3pxbziOCbixTRoeL+0B+7jsddlXqiSXJI+29hsOeXGLxLxVN6nH7wmqh9MWTRRTO/J09Bn0Hn03IJ0avKcjiFdsRi5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512847; c=relaxed/simple;
	bh=JwGkgzwokMzpIScEyi1ei75DHmBzq41nQT/f/BciPTA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IOGjLwXQVcJunRPwjFEEFhtn8f9/yNTlbLqElJdL1J/weWSg8VeIzjp7BrozVUQNB8SE0IplZzgsvu0396IODUxrkyV22h2AEb1nZ/nIyJ/y6K9qUUGJUy+jfPmnJUb3INl+1BQATw8RmMlXtDIQynP5u3HPW2WEOU/FrPAZztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0VevoXq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0VevoXq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3574747a91.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 19:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791512846; x=1792117646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JwGkgzwokMzpIScEyi1ei75DHmBzq41nQT/f/BciPTA=;
        b=D0VevoXqUSlXfGT/xvScGUIUboLpPuk5Dww34Q2KwdgxEm8QnzftOItk65ew1YhqNf
         psDpcfcV42I8iSwSN4e68D+Xq9EddKLN8R9cO1SAfLi2olUD1zkuAfyaLgCQ5R1yDB4S
         6IiOMONrImuLKiKcXtDHxH9q5MDo7hZL1kLUvDPeLY7OphDl3aowNsjBv3sWcUnKzJ+k
         3dlEHdtROlbhcEJ6UYMohySoAtY/TTp0wKCBiNdsoWJ8wiYpTqI84zCoAo324rfBsXmc
         Rkb4aJcIkfUfVrsNQ3mxKFhpUEHUgp3nsoeFplMtlNLoTUArjDuriB7nMn/GU8mVFAig
         hD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791512846; x=1792117646;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwGkgzwokMzpIScEyi1ei75DHmBzq41nQT/f/BciPTA=;
        b=mp1IAlf7WWxz+Usa98wF+PDJlQOKd3Sn+hSOWAASCWgjuSS7NTLc5KTTY/8Btibp0t
         OcCD8n+UgZ+xjfdHAb0V6Ytog7NN36HKBxk55s2DJ2WMT9YSPA7RKBnadya1sDL0M/lP
         91eLn2lrfC6kIzTSG3WAvuaYYDLi64Dq5QJdoRUAhDgeslwVbRHg96Fx1oh7j8jyDeqf
         9rTBdvYdnU2qhhnqVtmiAwibSwEfRfUVkYmwJxOIyOeAVftpxmcsR/zEL1ZjmvaZCDYQ
         IBqxkC+bftCvWmxApg5Z5SyiEPYAeEfofkuVmrXdVa0bm+1NyjUa7juMXVQP37xYKXcA
         y0bA==
X-Forwarded-Encrypted: i=1; AKwUvBzkawwVZb/ZcOju7N9usGzmHPYOo6UMBIpNp60VhOtgz3vzNDg+9KNGk6Dc5n8vyIAG/ruWAco=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqTvCMqB3WVw/ovnY4VMnM8mQUm/RfEjhUW0HSMBWAiv+CFpy/
	NnenLpacYw5k3jwHlszgvYdxRggZztZbJS6f+3NwgIa27WFHXubMOUkx
X-Gm-Gg: AYBFou0N2/e1z3poLMoXqqdrKOIIszrlfi9oWkpYSCJ4BoPiR6fZigiOyj90bCdII+Q
	VYFMb39eYkqMLU4T8oqGbwSgBXCcdv3COg2JKwmUWGF8rgGdoRGTg2Gfx4j4qrhB8kKUc7W9g5y
	h+2PyRy9f3+Ojeu9IE/PZHap1T/puRZjNva3CcqZ+b5bJNTT3fQ9xECdU/XV87WxfBt49htA869
	lilgvdmNgHS9LoXMGknHJg/VSAkLRHIPLz07OWgWqQ51upoogQqeoVsDYWtEBFFw9UxptoB2ZP5
	Cr2o6iXwBosRqiZHQpw/TBdk1BFsUOreDgxgERM6h63CgwMQO0zPITwGNi3KKpkNHQz6qOITXJy
	StngTg3EigXUQd12Strow89n9FZeKZq9ZnSE5LfeMB8edV75zKDSuos5UfZ/gWLxF7jUFIs0eI3
	QE/XHeSFCUhvVdUlhI4ezbDppwTVdSNl87bHOljeIvgq2Pd/u3kt3MgUqqoQe3iS7BTfCK8LGL7
	DUQVMmwLLxdGH8gT7IVBLlL4oWW91KOISbLcmrP7k0bRJoASVh24zXPK1xY0EoEks2nfyELMIJQ
	VliEoXBqHvYexo/m
X-Received: by 2002:a17:90b:570f:b0:3a7:da33:ff2d with SMTP id 98e67ed59e1d1-3ab3ac5e4damr522714a91.48.1791512845632;
        Thu, 08 Oct 2026 19:27:25 -0700 (PDT)
Received: from [0.0.0.0] ([2406:da1e:f76:8d20:77ec:b3e7:5372:2d36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9633fsm1491593a91.6.2026.10.08.19.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 19:27:25 -0700 (PDT)
Message-ID: <2f94adb3-3390-427a-b223-eccea470ef16@gmail.com>
Date: Fri, 9 Oct 2026 10:27:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gaoyang Wei <yhyxwgy@gmail.com>
Subject: Re: [RFC net-next 00/12] net: add the PON subsystem
To: John Crispin <john@phrozen.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Christian Marangi
 <ansuelsmth@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Gaoyang Wei <yhyxwgy@gmail.com>, Ziyou Xu <xuziyougm@gmail.com>
References: <20261008143249.3439762-1-john@phrozen.org>
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

Your cover letter explicitly presents this series as following the
framework discussion I started. Yet neither Ziyou nor I was copied on
the cover letter or any of the twelve patches.

Given our participation in the original discussion and the cross-vendor
follow-up, both of us should have been copied. We find this omission
inappropriate.

I've added both of us to Cc. Please keep us copied on future revisions
and related framework discussions.

Gaoyang
