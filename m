Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689108;
	b=zjcbQQ6j+csvMe5Y5l6q5wkHdkclKZRJ7sZY1Z8IwNrtu+JJdcoXbbpalSauRYgmL5Hf
	 BtnlRIdMIJHF15v8ju0V9xqLAfhk1gCB0GVVvm/Y1uSc3d/yp8rs7d5KRBYCwMeSfX9Ga
	 ObT4hJohUVNvg2cvwgbzSzMMYpi2ns2VEu9PzkFcE0Dz3G3OCv1TFRYu02e6yTGG1RmHm
	 8aQCdrXGIea4SLvuihMCb5RC22udeDArkzKYPhY4NaAOiyONOIsiEbaQNmBkBlasJVU+Z
	 S6jguyOJl+3jiUajYo5wA3w/ozyMmutBqGiwRG1Y0YlQ1LQFCANY23IgLG9JT8D60YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689108;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=X2uug97+9g9Ifw2alnlucQZ1byzTMHdm0Mg+gmOCcls=;
	b=yLVxy2bsJgtnCxmh86qDQtMICSWdDc0QthLhOLuwPkgRdidbilMOOmTrwJ71YoGtCpTp
	 cTSCq09oDMmNTS6Bb8mJTaYFhS1w1bgrJCSo2OeTURAVbA8PfnSDotHaP34yvaJ8ApIPM
	 0VqXU3KGOjAV4goEQhE83yubU3panVzfo/YG3t8mfN6wtaUrn0ESLHfuYtmGSDFcJSF3F
	 He89ETV4kLDxZt2/q0iSYWZ0I+tX6JbRKLY/vR2iMMhakp/wtQ5j//k8pq+6o8ClGN+CV
	 SNN3vilOHSHMpcUJt94DTbfzT+yNsQFKnRVhTbiGOjiOyMWUHoRw6mDnYN7QRV/qHZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A5606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A17A5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4649b35bso22592f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689106; x=1793293906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2uug97+9g9Ifw2alnlucQZ1byzTMHdm0Mg+gmOCcls=;
        b=xcbkNcq4AuSM63SFUhXIY4RFzHnE5sHvG+HUooo6wmrIEIowvezgV9cuuITFP+A7iH
         OoD5s83qN4w+uyLbniU9wpiFzXDe/lkQJmhC0wFY028QBNVTZOY8dFKZj4MNALcw0bND
         TKxKIjplLYC1CHEKvQimXj2eUvwE24YyNiH4DWuyWU/X88c2uqSxuFDPmWAP7yabx83R
         htO3UDxG1G/9Ry2K/VjhRLUBsgUMCjbNwmoQ0FAx9a0AYI3nGt6qV6bC6hkQZRtJCvRT
         /vdSSSoy8Shcxm0/QEm56RAqee7m+LqPbZLH1yRs7VuRAy9QygNSLoyEFG6Cp9GcKp7I
         IvAg==
X-Forwarded-Encrypted: i=1; AKwUvBzZ0yyorZJC261phXK6gusBqR7jbVz0bqVVjo8YAFyoshRH4q35CoNCknUBESa7rU4kIA3mJGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPBnql+6huZYU6Ge+wnWFt7GkryNvyXgxbkdS9VKSP8aXglPTe
	kgQn3VGjOpAz6erH0qvb9jb4LPpquZKAH1gMo+gWvcCYhAzyzqpQ84fZ
X-Gm-Gg: AYBFou1OQQ6wdRI6KIAuleiFFC7kV92AvrEk33m86GcQPJmbi+dMapKF+9iavnkwexu
	JMv/qZ6m1ict1rqBAiJ52kkZfOiWH2gJjOrjY0VqGS7T7PaMsWVFyAPVaXgxcVDcB+EaYB/ga0X
	Xwo5Z7Xd7a4un4eo6OiPCU+4ARnpbPy5tNwZROScELTx5iF7jCK/q3kCJglMELrvCFNldcfAyau
	XomRgT/5sDamDHkFNOWous2XSezA2g9GNJX2/6oh3cYz3DnXRHdpfW+woVnSwko7NA3jVl31cRC
	WIQ0H/uMzrK8QiLrlQNuAkJcajEyE8MQ+3H6pBYii5UYOR+AN9GLlxajlP+uMoSYBNKJyX/ZEKM
	PCyDDogyLzCdswT93Hp8k+7G8Tz8j4bgGtt7bU+ya2RlloAVBwZvUinqh96zQCWRa/K/0XG3LZV
	gWIeld69BlRcqNO+cdUXLfkvSZHmMq2BK62abxyHHqsur4apPEidz7maioOB8kvkeiRZ1AxJttZ
	1DI5Cn9x+O7H5d0U64pnKq8ddvv4ThmXyr5bLXPjQHkcJAjvOl3Ycpu6snudwfbabYk2PYuT6+3
	tgCyA+7pdPlgZ2I+ggMqn6nAk825N9U=
X-Received: by 2002:adf:e004:0:20b0:487:1ddc:aaff with SMTP id ffacd0b85a97d-48e264a640dmr8341797f8f.44.1792689105826;
        Thu, 22 Oct 2026 10:11:45 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2582a53fsm13532427f8f.32.2026.10.22.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:11:45 -0700 (PDT)
Message-ID: <5100a774-9c85-44bc-abf6-9679f8395856@linux.com>
Date: Thu, 22 Oct 2026 18:11:44 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: net: amlogic,meson-dwmac: list the
 compatible combinations
To: Conor Dooley <conor@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-2-tanure@linux.com>
 <CAFBinCAejxmeeHyDy+vMSg6dBm+9prhEo9qZ7FAsiWNB1W-HXw@mail.gmail.com>
 <CAJX_Q+3JLn6oTt8qTPM-muKsY9JbTEMwqRvbamZ3vqg_Yymsmg@mail.gmail.com>
 <20261011-starship-foyer-1105c1b35e31@spud>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <20261011-starship-foyer-1105c1b35e31@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/2026 22:13, Conor Dooley wrote:
> On Sun, Oct 11, 2026 at 03:16:18PM +0100, Lucas Tanure wrote:
>> On Sat, Oct 10, 2026 at 11:04 PM Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>>
>>> Hi Lucas and Conor,
>>>
>>> On Sat, Oct 10, 2026 at 12:59 PM Lucas Tanure <tanure@linux.com> wrote:
>>> [...]
>>>> +          - enum:
>>>> +              - amlogic,meson8b-dwmac
>>>> +              - amlogic,meson-gxbb-dwmac
>>>> +              - amlogic,meson-axg-dwmac
>>>> +              - amlogic,meson-g12a-dwmac
>>>> +          - const: snps,dwmac-3.70a
>>>> +          - const: snps,dwmac
>>>> +      - items:
>>>> +          - enum:
>>>> +              - amlogic,meson6-dwmac
>>>> +              - amlogic,meson8m2-dwmac
>>> Meson8m2 dwmac reports: User ID: 0x10, Synopsys ID: 0x37
>>> In case it helps I can submit a patch to change the Meson8m2 .dtsi to
>>> use "amlogic,meson8m2-dwmac", "snps,dwmac-3.70a", "snps,dwmac" - then
>>> we could move it here too.
>>> That leaves only Meson6 with a single fallback compatible. I don't
>>> have any Meson6 boards, so it'll have to stay that way.
>> Hi,
>>
>> Fine by me. But I think it is best to wait for this series to be merged.
> 
> In the second sentence, you're referring to the dts patch I assume?
> IMO, you should submit a new version of this with the 8m2 moved to the
> other enum and Martin can submit the dts patch now, since the current
> binding permits using dwmac-3.70a, no need to wait for this to be
> merged.
Ok, I will move.
I will sent v4 with your Acked-by, since this is the change
you asked for. Tell me if you want it dropped instead and review the new 
patch instead.
