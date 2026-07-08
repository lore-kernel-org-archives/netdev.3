Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C064D8DBE;
	Wed,  8 Jul 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522644; cv=none; b=DjItv51ssveiltbN3VjXEfrxxP+dwfaLI8ioKRMwYUlaBux/6D/crnRptu1UX/M4rgxzCpg/JWhnIlFC2mdgMOkAbONYo6IvGAAsHbSo02gh3lJ95EzCxdnKfLEUpW5Xp+gZB7xmqifhfJQ66C4P7yVLJtGKrLXK0VSQEXwHM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522644; c=relaxed/simple;
	bh=JYzf/onF9NFirTAfSc9PDQP9wK5ZKsBVM9F2HTMBsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM41JZ1XucddLavXBBA3yHggQkdlwDzClF943XODaAROkPhtkgSGCmRP0RzsCD/kBtfFjZeYo7qTPWi9g6pChss2LHgkmfl16qtJnR1gtzPm60gY5sI8LjwcIX90plxUnGplDi+Gp1osZU0Sji7kuimc4IFb+CZ3YJZsyfLCF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3jCUi92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3jCUi92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504D21F00A3F;
	Wed,  8 Jul 2026 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522643;
	bh=aOSlRVOOsp/b8/M0wS8/T7JwtXcb0jgJm7bcNhotsfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3jCUi92le+Rm3J0/Xv2R3TQTMFaC1ybqJgwkDl0oMns6/31SZHyiD4k1nsIKb/X4
	 HqFlCa6jS3smLI89QvFeAYIYiBeYF5m4I3iNzciYajFVcq8F7N3g2qhHKKb1+Xbi6/
	 p+cRzVcpAsw9JijkQIMKHQNQ4ZkgEmuSFsPqcEovqQVuNTq6FRdd+xEEWqLE2c5GVB
	 JPv1qB2AYP1526neWBmBIa0lCXYYKOr7Ftxc1pInZivoHXwCEer3QrbWEPVxkKqb2/
	 SVE2FuLIGYw9fHA7YiHQVK9j6NB1vYaOyJ//CbJPpWXhaFvlITNWFsClbqG/s4bhe0
	 skhkCUkYMENGg==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/4] clk: qcom: Add RPMCC and GCC support for the Qualcomm Shikra SoC
Date: Wed,  8 Jul 2026 09:56:24 -0500
Message-ID: <178352261615.2235436.7887300430709425990.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 08 Jun 2026 17:51:48 +0530, Imran Shaik wrote:
> This series adds support for the Global Clock Controller (GCC) and
> RPM-managed clocks on Qualcomm Shikra SoC.
> 
> Qualcomm Shikra SoC details:
>  - https://lore.kernel.org/all/20260428-shikra-socid-v1-0-6ff16bad5ea2@oss.qualcomm.com/
> 
> 
> [...]

Applied, thanks!

[4/4] clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC
      commit: 01cf3e27824d1cf2dcb815e59087c6556819b039

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
