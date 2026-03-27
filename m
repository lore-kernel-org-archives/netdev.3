Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A531A56C;
	Fri, 27 Mar 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611522; cv=none; b=NVma8pTj5Z1olVAmL7HMv3M3CvSvfBfYMnUW69NQvrJzzN1/vCbDokt5rZ3zi7ux5aZmHMrf+vsrkEO8e5FtpfkCzkmAwBSdXXyTsbJQWuvOUz+EuUsbgOpDi0IsPFF+seFfEa/ZKU3XedbO2XMVbrmX14iwQjg3AIaXjp7r+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611522; c=relaxed/simple;
	bh=Y/In3PPWyQ27YKVvZDsM74MTjLC1TLqYi8sV8yii7hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAtyc+818yYrN3cCssqH8tLRWwFL9y7LPdwEIyHIblqOrEH3GBU4LYOP6xhyDdX8gz4pXPnCKFNWhEUJxBfbCGR1J+1982ZHS8kEWoqcHioilXENAhyEr632XRpqHSlui/yulC82a1woozNQoSWo/VYb2uvKAgstRD5qnXNYrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWp5A9/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWp5A9/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E33FC2BC87;
	Fri, 27 Mar 2026 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774611521;
	bh=Y/In3PPWyQ27YKVvZDsM74MTjLC1TLqYi8sV8yii7hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWp5A9/fpHSziGYkCt5ZPaYh2GcjqYjJbzIJpxj8pig+NeiG4QLZ2ol+v2i/ptX3c
	 v6gXsbdfByn9pHS5pCLMQuztdK0C7Uu/bNPwRDcFLHr44J4PlcSsVx+COaNlZ8tWZ9
	 074KWXaV/7z3rV59/fchAiTQmp7XhiJTDk+0QDqPj04BniRLsqy1+wAbG21L0IyvDQ
	 1gEbalwvdi6oCKiPD0s5Xy4pBVcI+XkEiPVdqEipNw9TZ+8f0NRaW7CntCw3VqrN6s
	 iNok2lb+MMF9MIG+YYw+07aCR/TuvLbH+/4Gbb8pp75xXkHYc1FFHJI6naYW3JsKjx
	 UQ0J2YYIwL2EA==
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v6] riscv: dts: spacemit: Add ethernet device for K3
Date: Fri, 27 Mar 2026 11:38:31 +0000
Message-ID: <177461143950.339028.17970705137917996650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326014617.1011732-1-inochiama@gmail.com>
References: <20260326014617.1011732-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 26 Mar 2026 09:46:17 +0800, Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> 

Applied, thanks!

[1/1] riscv: dts: spacemit: Add ethernet device for K3
      https://github.com/spacemit-com/linux/commit/74657a376960252e248089e518cfaaf813906989

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
