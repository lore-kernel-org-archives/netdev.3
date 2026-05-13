Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2A3BED6A;
	Wed, 13 May 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699393; cv=none; b=g3s3FpF1jqqNDWrlKNryhd1uvy3Cqsdd6iPMk96dp+PsEJET8D+bggzTMZcHhj8ZJ0T9Fy1lyp8c7RMeqhbRlxPhEwCO854kxpAsao1VTRU3JNdZrfTo9rol/boOBC//tlC2j9nC+sBJe6/ZDVcPTyBBq6keBVjrp4kGdMj1OJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699393; c=relaxed/simple;
	bh=WL5OEvMUQQ7OrwuuyIA4c+m9KQP2c5qq3Dghjnt1vsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VroVtYBVj1sIlS+GqnaIgM/wj9yBJ3xegP0Sf7VjD9sWiWN4NA566MphGUEXH7YvP6kHy7hXUlExN4BYELkTofETja60aE7NvY7f1AWMCaoXNQDMg0fd3v9BzydbywdeN4ef+MW3tz1lOzs85RnWgMaRRi3GXjfU+vGJim2a7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwSY5afp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwSY5afp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA1FC2BCC6;
	Wed, 13 May 2026 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699393;
	bh=WL5OEvMUQQ7OrwuuyIA4c+m9KQP2c5qq3Dghjnt1vsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwSY5afpzH9tT1aRPBOo7ZMB8zZCKrGA8t29Z+6oHW9kj34li45H2wgaWY3N+Rf8P
	 CT624gKtIvWGBwjAWoWas6/VFNlI6827X2z2eXwE/41SEADE5PkPEVnq6LudLiRJDI
	 UwIIloIwpaBhRdCuy3DLTJbIq0zhhQ64YveY4mnvnxkms0ugnEy1RsDN9m8PNRVBAY
	 7kULZOBR+wTXBAGsOlikPWLh+gAxusbJgHxpi4LFxnj0xfRwvm+VtsQBKinqOq2mZz
	 I29VdXxW/mjujsuaivtzhySlibeVepFkUAtUeRdWrnPmvf9G505Btz7AF6Q/xBcKaQ
	 C/v5YPUwL/bMQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Wojciech Slenska <wojciech.slenska@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] IPA support on qcm2290
Date: Wed, 13 May 2026 14:09:29 -0500
Message-ID: <177869936437.1496622.7203773008975759520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310112309.79261-1-wojciech.slenska@gmail.com>
References: <20260310112309.79261-1-wojciech.slenska@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 10 Mar 2026 12:22:29 +0100, Wojciech Slenska wrote:
> This series adds IPA support for the QCM2290 SoC.
> 
> The configuration is based on SC7180, as both SoCs
> implement IPA v4.2.
> 

Applied, thanks!

[2/2] arm64: dts: qcom: agatti: Add IPA nodes
      commit: 9c633eec37782b2d31281a0289882bb419b5ad18

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
