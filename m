Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572863;
	b=hrgP4aa2O9ZjFEUfMNpj+CTFlYWP73eZgUkjChuAxjJluWHOOWxqzSj4RpcpAnbRgAdB
	 SGiT7RhMfIJyFgWBqacaNcapgOrrTz/OGfkmYXIB52QsXlAxtsvXGCD9Pj7H2yc8g28Cl
	 T9GIxQYWONfkPUpTX5aaTdHUTD2E3hOk+g2sEl2lB6qH6nngIAf4DkIiyHOzGa0pxbXcf
	 Nj489S2IUk7WkLBZ5h61uqb99HJqnsp02q1EyI3kf6pay2RbDT0tozRU+hHs7thwrErBC
	 1UiqGqXQygzSG54QnAlUEIY6nmUSbu8ig7fj2oFBr//CH4s2dJtN7j5PbNfNmGNcPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=1VXu0Oww6+OgZ9eimJftYFtnEGIYdPnrJIKGaFXfMarTvK6sEVpejI5FXtB2zqhgSwZ+
	 ZR6gCh8pD63njZ0OCjyrLBWabroUGO0vJVgEY4owk/478JBPJIDzht9HPd/zoCHkqHyEQ
	 Lf7BZ2cPpmQYx3UfgAFqRzjqrr5mwYo/9PXA6v+DXmB4Kwbq2y/ot7wbCxUmeizQtw8a5
	 d9lqfUkNXghg7zNNJT72tgKPv0yuQffM6VRDVmSkRwsoQkBVh9x8lSXLk9EjEnrq6vBUM
	 e6JjWwLFY2bDJdlkt1ZyPKh/H/fElOOyaDnExz4iBHq3td7owq5d1S6unuEp2ihrImQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3BtiiFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE64606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3BtiiFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058A81F000C4;
	Fri, 13 Nov 2026 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794572863;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3BtiiFk97rQ1I/U7DaU+UF74RPq7wIQs/yQTOJMkPuMs48d4hwxUUVDOLWRzqxDx
	 I9VZ76RsGYim2gTdbSUDbq2k24eHsIr7Jwgs2ZjdMFMWt5Ix9rYhOKPe9sItPV1PJA
	 Vff46iCY8IhquTe5lti1UtsYHLb8BPZF7NoVWxk6UnPP2kEs5UwsSx2pRyHC+ymuLw
	 6E3tqYCr84iB9O7nJImq7lHKCA7zn3JbqAxYCVRNSHSxHSfnaY6jHaMneCxUDOgTvU
	 6rBvaOKPx88S1uRhSi3t6sMZpKZsdTJFglLzQZ4lwrpSdqfzNv+QcY0bSp1D3+WIIc
	 GlQ23vy8QH7Kw==
From: netdev-bot+sinfo@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel.machon@microchip.com,
 Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v4 1/2] net: sparx5: fix RX ring stall on frames from
 inactive ports
Date: Fri, 13 Nov 2026 12:27:42 +0000
Message-ID: <179457286256.2168702.18264934758853091645@kernel.org>
In-Reply-To: <tencent_76692FA5A375ED2DD8652E064B0A6BA09007@qq.com>
References: <20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577>
 <20261113122439.26292-1-memoriaru@foxmail.com>
 <tencent_76692FA5A375ED2DD8652E064B0A6BA09007@qq.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
