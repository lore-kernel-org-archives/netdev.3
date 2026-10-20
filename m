Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522923;
	b=POGT/cmOM2VGbFWeu7n7xHHlba8n3kAi2Rp3d2W+QHqETnpkGzAr+hHm/Pd4AEy++4FK
	 ne+q9ZgQkyUz9t4f1BOGE6IrF5JU8TPjq4+wT3A/v9LDP8hJavxGWF1cUoYKun7u8gESE
	 OKUB1BPgVsXxSjzxdT9Yf8h+kTX+zl0oKWlinR9DTN9E1kroJzbbQhJwlcqt3XMH+GdMb
	 3fSGaOTpdmB3dDBD7XRM00J2RmkLyEvEtnsIR9RLM6tYZsEJLy7Ku2JjBL7kDOlY2L/QQ
	 8193u6v37w2fP3+q62WdKySKLn/5gCBaGXWF1VBYaJ3Ttb7zDlXLv+njjfimYr13bJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SNUUL9iqnZn0/jRsoq0aX1B7whooxdO2w6cP+STQzJA=;
	b=4Uk5UXgEoovrZeix1BtzHmLVvOM6hihohN1PMQDsEkmWDNqU5/4HLW58KzgfCLrWPNXN
	 fWxmIYn4swDabP075nBlRWHveDfTSP6qTUiXnYmNSNYwpEvRpgwZnUwcO8DMxUUKh4eRd
	 9+R+sBSJYhf5ZNUuak6VqUhUbDx1DHiNIovNrJ9CpqhpXeJ/bgzDq8piHFHSqsLxKcvyL
	 AroBNx5nog1YzOtnQ8b5gDFAR56ZSflb+OHIuj9wlgddZQfX/MVeW7rFXVg1GwY0dJLub
	 1nfIuYQwJPD+Brzi5rzCMKLge+9qS7TPXi5K52q2OrQqPAnVN2mbhzZ05QTXZFUY7Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD6UBKia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B8606A31B;
	Tue, 20 Oct 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD6UBKia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E227C1F000C9;
	Tue, 20 Oct 2026 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522922;
	bh=SNUUL9iqnZn0/jRsoq0aX1B7whooxdO2w6cP+STQzJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lD6UBKiayXxIonuoAXPQGgIZbs3ttCspAdVV0EXsqXwdeUUfjbWK4B+iVplV4DgHY
	 8XkXeekkYfpFf0j4oIThHrV1p7HTbc88lg/BGmxkUJW/gB/3UaZ7T1VqiooO27tHu/
	 nBBHRNz2LBhPXhs8EotkLipBtbtabKnXkwWYAySBN4l6rIuLNYAWaI7xZ2HZhZGkGg
	 6GyCJO3SncouPLlCmRmNL9bUbNCGiZ8PeDB+Q9jatvwMiKr5o69sXuLj1ESgHHMYeL
	 zOsNaWefuGmGln1e/rb5qZLdB0kh1JYAWuNhjKoW60J0lMlKow0XfU4Aelsum3feUI
	 tM0/ASIQL62Zg==
Date: Tue, 20 Oct 2026 12:02:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Pengpeng Hou <hppiscas@163.com>, Elad Nachman <enachman@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: prestera: avoid overreading a short
 firmware tail
Message-ID: <20261020120201.05563c91@kernel.org>
In-Reply-To: <179194861751.160550.7509459587869597580@kernel.org>
References: <20261014032540.14311-1-hppiscas@163.com>
	<179194861751.160550.7509459587869597580@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 03:30:17 +0000 netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Please include answers to these questions in v3.
Failing to do so will result in punitive actions..
