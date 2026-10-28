Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176190;
	b=krRoUtT1eX1kU78FQDat+yW3VjNn/jWfwNn4WGiQPUj06P8BprIK8A2xfKulJld3+He2
	 8Pbm9w88UOL7/EScI/8j60II8i2gCGjpZeLIAmQhrdydqyrw/eIg8FZapZVxGXIdm5hnB
	 HtST4FpgMXvIAjpomk7BQIJNGLwt7Sv9ArU0IGPMdtLTxv/dLm8PUJrP+fT41z/fQO49H
	 n6j6spnn7uie6l/YE1GtBM0pSirN36voNSJcXmOYF2tNN6X6+ANy5aMHPc44uw9LR5BEa
	 G12zGKFueEgdNP8QGwh7ZIxQK9Y181O0LsGBg1DD+rixnpUa6baWc4r1OOrdO0AjyXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176190;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=tSsll3kKf/A5nOKxO5JS6a9ssNuy0Uui3cKpvaZxhZ0=;
	b=4p0hdtMA7GE9Jlv5zDU6kGDKuDBBoS8NrA9P2UPQORaAWnVm6KarfimWxkG9pgr0M0eC
	 /7gHu7xAbJc1vsFUi5L4Iz/wgLp3J7UccEtE3O+gtPI67ZhJEjB0+chwe84rL5LMrQrf3
	 S/AOcX8C5tzaxQddeF/UjYNf2O8Ehh+sG71eNGnYV5nz88rgJxuMqMqGSlfvuOjsN+IiS
	 UXEEU+AB23qi/CRXCNd+byGsOJCNwkvBslgdAoPvRR53+KANOH7/dmh3ewmCEyay6sYbu
	 tEvpI5CySogLe7quDrcRsjOi4kdOfHUqB2hjmDNtetnxVvoc9mdTyu9vYwvTihcO+tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ5Q5aLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112D606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ5Q5aLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FABE1F031E0
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793176190;
	bh=tSsll3kKf/A5nOKxO5JS6a9ssNuy0Uui3cKpvaZxhZ0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=eJ5Q5aLbqDPJ5gof5fltzVkIsyvjcisnT6uC7Ii6JTZqbS+D5XYGScuRWpa1tX2SF
	 MVQZq27HUDKZzmlR5s4xpRjwQ/IS/jZDPXPityyrXnpDNVJhMVii6hBsp5K83mmYUe
	 nMSJnU8mMA6Od/5vfvCI54TKcHyd/cLIN3y/U7+Y45y8qVycueSy+oqPYbpQwOXPDj
	 kpQlh9ZUujRsVeCNaZfzS4TyDzpMPG4yoOa8BrV8BvXwHI5crpnGofzIP5SBfNCevQ
	 r8UivzfCpUNJW8xmuZzi80gdrABlR7w9ZJdaIJAT+pa9QULQ2FjU+xSL7Y5Zu+yyqW
	 Y8ZymlLzf8PTg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso776278e87.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxysWmEa7yyVSwHbBlLkip6iilGEdBJUOtSC9B/NhJrkfO+2UcIkEGC2hLxDSxRUQb/NmuyzBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPpBB2K9IAqbGpetLTJHJuBq+unDM1HJFnBEtXa49DDkvn9j2W
	00c33Be5A2JgZzps0YFYO5GtwZussSzeH4mke8vL7WPhDYSUdt7gftkR7x5D3iti/HNUYCZrljY
	dHkwX0y2sSPNYSgn9nzxfX4URxXhLnw4zbtajBxkEEA==
X-Received: by 2002:a05:6512:39d4:b0:5be:4904:d2c4 with SMTP id
 2adb3069b0e04-5bfcad7e51bmr690736e87.15.1793176189147; Wed, 28 Oct 2026
 01:29:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:29:47 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:29:47 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <5114bca8-91bf-4db0-ae12-442d21ebad84@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-3-a34d778ce9ac@oss.qualcomm.com> <5114bca8-91bf-4db0-ae12-442d21ebad84@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 03:29:47 -0500
X-Gmail-Original-Message-ID: <CAMRc=McWSHn03C9DZ8ZohebfDA9z8L=xJ05KDOYEm6n3eHPArA@mail.gmail.com>
X-Gm-Features: AclHuK9WkISxEdVMPKocpMJX1vIBeHnYYBYBtz3ekKYCE5vss8u7OwiUvounMh4
Message-ID: <CAMRc=McWSHn03C9DZ8ZohebfDA9z8L=xJ05KDOYEm6n3eHPArA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans-sa8255p: add ethernet nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 14:32:16 +0200, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> said:
> On 10/23/26 11:02 AM, Bartosz Golaszewski wrote:
>> Add the ethernet nodes along with their serdes PHY nodes for the gearvm
>> variant of the lemans ride board. Enable scmi7 and scmi8 to serve the
>> EMACs.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi      |  28 +++
>>  arch/arm64/boot/dts/qcom/lemans-sa8255p-ride.dts | 213 +++++++++++++++++++++++
>>  2 files changed, 241 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
>> index 4c155cbc79754af632848cd55b738e3ef0511cb5..c64cfd279af458e24fb48083ae549c96cfc07485 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans-gearvm.dtsi
>> @@ -58,6 +58,14 @@ &cpufreq_hw {
>>  	clock-names = "xo", "alternate";
>>  };
>>

...

>> +
>>  &firmware {
>>  	scm {
>>  		memory-region = <&tz_ffi_mem>;
>> @@ -3226,6 +3234,26 @@ cma: linux,cma {
>>  	};
>>  };
>>
>> +&soc {
>> +	serdes0: phy@8901000 {
>> +		compatible = "qcom,sa8255p-dwmac-sgmii-phy";
>
> Hmm.. I was hoping Shawn's DT reshuffling would land first
>

This series depends on Shawn's, I too hope it lands first. :)

> Are the PHYs hardwired? If so, you can move the phys= reference
> here

Yes, they are and will do in v2.

Bart
