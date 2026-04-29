Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01715217F27;
	Wed, 29 Apr 2026 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445964; cv=none; b=VMbyRt/DHYoDmW3HPvqasg/J9Jktnpauxb/lL4FR7M+fwh74pcKNoZSCxaq30nJntT8Vx0xuPTxxXClRkzwTooNEkW+HrkFCYrfeAtNaAhmkdqiRdDTmjBDle9i4h7Kcyr0L4qfoJhZaH3ZuKjjSZhuI9DftW7C6BW3p9Fohdnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445964; c=relaxed/simple;
	bh=Ty5rDqNCr57ubNVebLW5G9qiKvLhrBRgSdwjbxVB//Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXlbtPPBe2GJ7g3asRI8578N8RUvmzsxQ9FgM9on+DIAueeiYrwkh+t6fEL/O08543L5/P3kdqdqJwR84NNhoKCSB5TitH9RR+LvZlICA7uiLfh1tZuZNsyN212Xak8s/0EuG4xo1mnk8DRcp55F2/l/MHmNtXZh1ZK5rOvopes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/cg4vGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/cg4vGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D286C2BCC4;
	Wed, 29 Apr 2026 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777445963;
	bh=Ty5rDqNCr57ubNVebLW5G9qiKvLhrBRgSdwjbxVB//Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/cg4vGU7RW/4xZcVjUfFD/VIJjxpJ945fY3zz0vmzzs0f/oDvWLpkIG2wGQf+hQV
	 H/67Y9EXKsCuC4S9iUn/s6ijzLiq3T/4VsWLtJKX6yn2A37DG/zoy2C3il+zy7ICwR
	 IEuq8aUt+/11kqeNR7P2uNUuW4mdH8SplRlXP4K6gQExRo9UjL0lpbH5t1+tQGp6OQ
	 1J1W68d9K1amvAYorNC8WMeV3lCJt2Uw+H2q9jM2VKljcCIUpruRN1v7usa4ySZhvh
	 sOBagINgJlzk9fr2AMpGPR7VRuULasJmSN32ll8i3+Yu+fVLaSn4VBm23zOzpI9IW0
	 lnTEd/o9A+xQA==
Date: Wed, 29 Apr 2026 08:59:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Shawn Guo <shengchao.guo@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: describe the Qualcomm
 nord-tlmm
Message-ID: <20260429-smoky-expert-poodle-30482a@quoll>
References: <20260428-nord-tlmm-v3-0-f16f08d084cc@oss.qualcomm.com>
 <20260428-nord-tlmm-v3-1-f16f08d084cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-nord-tlmm-v3-1-f16f08d084cc@oss.qualcomm.com>

On Tue, Apr 28, 2026 at 03:48:10PM +0200, Bartosz Golaszewski wrote:
> Add a DT binding document describing the TLMM pin controller available
> on the Nord platforms from Qualcomm.
> 
> Co-developed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  .../bindings/pinctrl/qcom,nord-tlmm.yaml           | 141 +++++++++++++++++++++
>  1 file changed, 141 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

