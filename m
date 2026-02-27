Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518451D5CFB;
	Fri, 27 Feb 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199933; cv=none; b=cfygtRS3zOin3x+US7vuf47XagCiHTPGm3fhgo8F+b0Bbd59G9eAVIx9JyScbjM90XR08Wy3ZJfD5GrW4q9w3YAgMTCARUmzpRHlmdwNX/n3JCzBPw8eTZiL5R2RqX8ow07zQ4i4Gi7eN02GpWuTpHw2mPnSrBGsEl3HgdJwSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199933; c=relaxed/simple;
	bh=SKsV8ym5l/huOSjTYD/pCQkRyet275DwzWDj6sr4VYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydl6MobTkq+RU29jFT45C9R8xB2FnVbggMFC19Ipap5HZBNO20EqmiprJgCVtQW0MU8QWXTv1IRh1GrCu6w5yfAvPO2XTAzDo9dqurKfZkFl7++xn9A33OeY/UbEX9yjuKMtmFdQg5UkO1qZQLgu+HclNt17/RmVRtKaSigzG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjt4tYvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjt4tYvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCC6C19423;
	Fri, 27 Feb 2026 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772199932;
	bh=SKsV8ym5l/huOSjTYD/pCQkRyet275DwzWDj6sr4VYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fjt4tYvDR3Yx46omuqjFG/bP3S/ZkDcwA2EJwv61oGtfT0Bfc7PBUxj8yF++zs6aw
	 GiCbJvrwSh4SEWXhkxmJenmX0SkCBEjBznUN/4+Rq/Yu7NhDPM9kjNbwldG5P4dvNO
	 WP3mzZ58bIN5Qjq9cV69tV7BvWokRIMD9p0QAKdqpidIjPyt+KsE+lFTYsTgxZDAoK
	 WkXOidUZrr6/uaaSU201eEUspAtbGCcT27rlVfOcK7vNSjMJrOOFK4xd8gyeLLCP3B
	 M0/g9WSR6Wf03IKI9ohI0JZc0W26dFpA5qtldoljrQZVH2cJI5xKLaHFEWFsMTQQtb
	 4viCazY7YBPnQ==
Date: Fri, 27 Feb 2026 19:15:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/8] phy: qcom-sgmii-eth: remove
 qcom_dwmac_sgmii_phy_interface()
Message-ID: <aaGf-RN9Hho8qEdx@vaman>
References: <aZ66OT9scKipRRu2@shell.armlinux.org.uk>
 <E1vvCc9-0000000ArLG-0if1@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vvCc9-0000000ArLG-0if1@rmk-PC.armlinux.org.uk>

On 25-02-26, 10:59, Russell King (Oracle) wrote:
> Now that qcom_dwmac_sgmii_phy_interface() only serves to validate the
> passed interface mode, combine it with qcom_dwmac_sgmii_phy_validate(),
> and use qcom_dwmac_sgmii_phy_validate() to validate the mode in
> qcom_dwmac_sgmii_phy_set_mode().
> 
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
