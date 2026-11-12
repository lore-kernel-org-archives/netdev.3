Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507930;
	b=MX1uqKmRb3Twu/kNiE6Z5AN4fsIlQyTtqe2WrNTGJsr6C2WVwCkEGKeYCjJl5qTYAcKF
	 GhMk1eaPz9rtalNorveCaveOktryQA4yXMtofE35YqWc45fhM7do0qwH8fRJfJT70IsMx
	 kfdw9J9wSucc3oVdlu3NC2jjF+WpTadrmQXJEI7sIkZcnTdH51Z1Akzr2WklYcpriquJ8
	 zllU9e6k4Ku5MBztB/+yy1OCobHcYgYM2I4FUgp47ZGFdcQl0bRUSk6ykPZd6I3pzg/72
	 2Fl7y3KAaQVXoqImfClWalVdUZ5xRekXaRdLWQ5dR7Dl9kZoio5YNaMcwBSrFKBkuVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507930;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bidjvX+TRs5sF6hJ4qbvArQhbDriXPM1GfNBRtGdlLc=;
	b=0pY95zSfK5edg1mzbe8ioteqkEChNnpu5ZZXBsFNz8BF/6/wXQefJRMn7kOEIoaqNvD1
	 5DT3Mfq3aXXBqjaB91ZVwfOPH8rfqI8yIwssdOdK+khl02Cn0J6GXVtzjgTBgjSPrvk6W
	 fUDI8ew03b6TfbmMSyS9e6MHYZ4FvvCF+1lFcUedxXLwVZsrcrf5E9Ll5p10/lX1Svy2E
	 1yraEhjUMf5rqplzwV1YXkmUV7HhqnHfwpXacSPeAgb9hdVqvu7rRZjj3Pkd2ZBe340kU
	 poCb0nb+WehjT3YpGYCbPuF0aP4PigANriaBWpozXXC2IWrDWsAVJyA3tyRvu2IBLhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joCIRw7z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0B606A32A;
	Thu, 12 Nov 2026 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joCIRw7z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32FC1F000C4;
	Thu, 12 Nov 2026 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794507930;
	bh=bidjvX+TRs5sF6hJ4qbvArQhbDriXPM1GfNBRtGdlLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=joCIRw7zJTF/b3SYVpGkuxCGQXazYIvQWt3WYe/r/R6Nx36JBmLz8kzoWZvPwIb2M
	 FY1LF+7VbSC9VizGWLydT0QiNUwBONDnN6MER0t8Drxl8CW7gNBjnVTxNVmZd34Woc
	 wB8DDo1/V93BlE9DC1yP3xZ8B+vzxqsvN6xGLJHw74OJJDMcqsj600y9FzHTPhm6Ez
	 wTiGz2tEG92K3gHIX2jZvqoozvxTeRKgBmHVLvWYJBq2T1z6DFkDWla/jb/Vc/+Oy2
	 MjJlV2t+J+7VCsd93a4lT/2ALUlgCvoZYHakFv6Jh1VapHYoGEwghe58bEeqK3z/N/
	 SKNPW/oXS5AQw==
Date: Thu, 12 Nov 2026 10:25:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ding Hui <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org (open list:STMMAC
 ETHERNET DRIVER), linux-stm32@st-md-mailman.stormreply.com (moderated
 list:ARM/STM32 ARCHITECTURE), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/STM32 ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list), dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Subject: Re: [PATCH net v6 0/4] net: stmmac: fix RX descriptors and XSK TX
 on resume
Message-ID: <20261112102529.1b79104a@kernel.org>
In-Reply-To: <cover.1794311618.git.dinghui@lixiang.com>
References: <cover.1794311618.git.dinghui@lixiang.com>
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

On Tue, 10 Nov 2026 20:38:51 +0800 Ding Hui wrote:
> This series restores RX descriptor addresses overwritten by hardware
> writeback between disabling NAPI and stopping RX DMA during suspend. It
> also fixes an AF_XDP TX-only resume stall found while testing the series.

Does not apply, please rebase and repost
-- 
pw-bot: cr
