Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714863EE1FD;
	Tue, 30 Jun 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815002; cv=none; b=RncUNqWCgQomFOkDhotmzxjYTWGKpJrrzj4yoxpDCpKzv3GbLAPMLB2mZFO50kOHGmnvmN/fEa8pl05WwKvNpjxC0H8BK/o75RrobsCq1z6zQI5PWE9U32OYrFfHvEKcH+MQ7J1roR5TgNCFYp4/TTlvKb2smW/pnsEpb6w7p54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815002; c=relaxed/simple;
	bh=DHteYR30RM1d5bPe1YPpE3im/+JF9z4CCZ3DJ0TOyls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAzm3/4ck3PC97bHAaB1YOG3zkYdwCqBvw6Iewq40/xnJkkJld1JhJMCADxUNMzkdiVpg8HUkpnuEmiHu98lrAUdJXuBkMoYa/CwtIao8KvrfSPPh1NDHa4/xjNAvujIq16VOxZ1W1YXZOH8+BVL29lU46H+kJyezNkNVx8lanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyBy2bQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyBy2bQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8E41F000E9;
	Tue, 30 Jun 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782815001;
	bh=hGencHR1rqX4oR1/IqjhQFQRDCZNECISdf4kfhlCG0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XyBy2bQcCpF6LYOuss3LRRJeQlCYc8dvpcRUfK1ZagqxIqYPz5p0WwpsaFIQBW9vW
	 IlOw0fNJJFpKyyg9iic4NuDm02LrPL3qHKHefNIo7aqpS80LB6lvKqynKgGBvzbREO
	 4ZvHpLHCO720wCr2vYLratFlyl/gE//Y7cU/ye1HTlkGVUfMCklP+eJYoqc/HjpTxw
	 MZXb8/jIFyvGrFJo82KLZha9Mhc3PkZrDWmDJGTsxLZUbwokWPsckf2VwK19WHIVoz
	 +qkE0c3p44BQOkrv6SHKYZtWI+7gQ0YPbPbglot3g6oJ2J7Z4K4XFytNkclDQawEPq
	 nxmkjQc7MH7Bg==
Date: Tue, 30 Jun 2026 15:53:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Radu Rendec <rrendec@redhat.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-mips@vger.kernel.org, imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH net-next v11 1/7] dt-bindings: phy: document the serdes
 PHY on sa8255p
Message-ID: <akOZFIowVvprnAMf@vaman>
References: <20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com>
 <20260629-qcom-sa8255p-emac-v11-1-1b7fb95b51f9@oss.qualcomm.com>
 <CAMuHMdXen+E-Ai51aWBa_KV9W8Fz2cQPpT-FG_kQ7akhrrYa_A@mail.gmail.com>
 <CAMRc=Me3jaZXiXa1sFXr=8Do4sCd+XN1pKTcWC8-0j78SjCkKA@mail.gmail.com>
 <CAMuHMdVUBgG0EFB16OxHisbxx-sBvDKvBPNZdpyDnmBrnX4ptQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVUBgG0EFB16OxHisbxx-sBvDKvBPNZdpyDnmBrnX4ptQ@mail.gmail.com>

On 29-06-26, 16:51, Geert Uytterhoeven wrote:
> > Russell King asked me to put the PHY logic for SCMI pm domains into the PHY
> > driver instead of the MAC driver where it was previously. Instead of cramming
> > both HLOS and firmware handling into the same driver, I figured it makes more
> > sense to have a dedicated, cleaner driver as the two share very little code (if
> > any).
> 
> I think you are mixing up DT bindings and driver implementation?

Should the bindings change if we have different driver and firmware
implementations? Isn't binding supposed to be agnostic of
implementations..?

-- 
~Vinod
