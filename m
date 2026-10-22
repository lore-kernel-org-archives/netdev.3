Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691327;
	b=UYYsh9ogKf6XDuRQO+jb98s7w5ZwQvGAl88Yvq/YSse49XrpLmz9DoTddWGM87mh82l0
	 Qdil5SYNBZYAqgDoxZe63KGs2tmtGPv30ci33kPVC+bZyEyCMgK8Dkiq/0/cA+zuglJ5v
	 noqlmwgHHHJHmxpNL2VsR2U4KijEJAqelFHF/U/2ybdYjLs7I7PpDQZ/4x0WGpwpvixUM
	 ve6Fam1SuYVTFtdsfCi4uvjyTNalyFQGkIrD1UltlWycpa+de8HiNGYNwq3GQup7UND50
	 24+41jiAJ2m9RimJNSunAFafCx6UYG7j7k2PAUu3aABb0+Iz4HtY5rcM2QVPgbbrmhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691327;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EPri+pnxfg/GkSkcUBWyDRaSPhtWuHho0ObTvb26NIc=;
	b=mXwSdVPmhgkDfkYFWD6wXtjUHrPo4ukqpUVRgK6mHCX4RqwGIrrJuY6n2+Ff4TU/HJ2V
	 /Fd9FcGLwIzU5Epp5jkbAsd3aMMajpsatPvoVgXdab1XaH3YXcO3ZdTP7rgA6QhjCQBp3
	 P7OcMwfk3igHCyih9cXtPOyfj6CognqUgnCsbjUm1ujymU/j9KTTweXzj1F7y/knxXxet
	 6sY9HHhXZblGSJniTggAJQkt5Mz4l6jSI6VUunO+lc5Hj2D5CA7pZR8A/NiV3nzzJGUvw
	 /7c7fG1oHnRlxcPXZ0+AWYSJjNyrNNJyR0k4eUVUdnYeAkR5YP0J7z+xk40vf0c8ovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214F606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C214F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so21855e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691325; x=1793296125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPri+pnxfg/GkSkcUBWyDRaSPhtWuHho0ObTvb26NIc=;
        b=FvFnBrrK5wHKun9LJzwZoVpw2XBsbo7PapLrGe+1jFCSsjCKyk+4AgONm7CL3KVhrH
         A159SdDQU4FjneIUVzKK+eDdG0HFrObgcexIHFzs5Si25MSFAwO4X1jfMZYZH5epUFRJ
         bgSJkDwSgdvyzlr+YgMwyomKHbuJVBqbkju62a01FpEvMa7eHTFpaIcjSVA1ZRswiFvk
         Sz9n1C2ctVrkaHYP/wl/JUMbWk9BRomIOp23+UAXiNBzcXnQT1DxUBXVU9acAI31sbiW
         Y6osDZLUAO6mKUAOgsMZX5WPDiOtSrWnBUVNG/cvdavlwHt7HVb/ZsIETp7BKy9fDd3l
         x+BQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgGeI4egQpSUgoZgsztfpSvZciHwEmZjJ2c9smCZqASYbxC9ov3zMoeUUGTRjHibH75LR2C/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKT1Qz/EiAQqdL8qDfT22xq7J9GORsIv9ZZcGzuSucABwucyVlO
	jncxe3Mm+b/Y9Ox0rHfbRKxwkghy2CkLqLi1BbzhwWUymuXE0574AwuBhARnqSVNMw0=
X-Gm-Gg: AYBFou1eM1N50Sc/BH5upBHa4rNv7tBiTBwR4w48wnS5h9F8fnEv/b26iGUTGy031hp
	DZEx1dgngxAOD9kGoCYuVRMqCSzGizuj/dbAwt28dYaNMmdinW26gnfjzuDtS9wMFNealh/dysv
	AZQAHOZrZiQ9h28ypzobhwQNm87O9YDod9FlaHgcHT1D0WtL7xHUrRs+xy2C070T6cOJacca+j3
	bevizQmDW1nxq2mIpAychdbC+jDWrNwXbauHgaCIEetFoNl3uBDuY7N7yNO5vkx1hVqJRyhDJZe
	mI1DzbkSB/GzdhfmmWsVQ6n+0JEtATvT7LlRR73aagfRSgnRJ0hDtgSZ1QEsci9fYuVKEJ71lDQ
	Gy1n5UXfEEC5dCt72Vt7rW0bh4gJA5jl4LEi/3TR/0k5d6V8MxevF3MRmSY2T3+Phb6aivGbfgV
	CSmHFsUbNF0MqkgNZLcTm4SYST6sVL2YVrele438dYh0RoD+oJFFDoZEViGNdGBH1Hg2kWMdGFR
	vplSYOpUMvqtapAVITwKBuqc4daxwzzOrc8SXWUnWo8GFtEr8g+lsGOAc2GxacLZ5HuKosAh+Od
	qBHox4OYxA==
X-Received: by 2002:a05:600c:3e0c:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a204b042e5mr54395825e9.8.1792691325102;
        Thu, 22 Oct 2026 10:48:45 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210327422sm14119865e9.14.2026.10.22.10.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:48:43 -0700 (PDT)
Message-ID: <9b5fe9c2-aca1-4460-81fa-826e05e88c1a@linux.com>
Date: Thu, 22 Oct 2026 18:48:43 +0100
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
Subject: Re: [PATCH v3 8/8] dt-bindings: net: ethernet-controller: tabulate
 who adds the RGMII delays
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
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
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-9-tanure@linux.com>
 <CAFBinCB8203vL6YK3+V2zDhz=qqeAwJoufPM60cD0Vz3s-OS6g@mail.gmail.com>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <CAFBinCB8203vL6YK3+V2zDhz=qqeAwJoufPM60cD0Vz3s-OS6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/2026 23:37, Martin Blumenstingl wrote:
> Hi Andrew, Hi Lucas,
> 
> On Sat, Oct 10, 2026 at 12:59 PM Lucas Tanure <tanure@linux.com> wrote:
> [...]
>> +#   phy-mode    tx-internal-delay-ps  rx-internal-delay-ps  TX delay    RX delay
>> +#   rgmii       -                     -                     PCB trace   PCB trace
>> +#   rgmii-id    -                     -                     PHY         PHY
>> +#   rgmii-id    present               -                     MAC         PHY
>> +#   rgmii-id    -                     present               PHY         MAC
>> +#   rgmii-id    present               present               MAC         MAC
>> +#   rgmii-txid  -                     -                     PHY         PCB trace
>> +#   rgmii-txid  present               -                     MAC         PCB trace
>> +#   rgmii-rxid  -                     -                     PCB trace   PHY
>> +#   rgmii-rxid  -                     present               PCB trace   MAC
> We have some boards where the PCB traces result in part (1200ps) of
> the delay needed for RGMII (2000ps).
> The remainder (800ps) has to be added by either PHY or MAC: the
> (RTL8211F) PHY can only generate 0 or 2000ps delay so the MAC has to
> take over.
> For the three boards I have in mind, please see $ git grep
> rx-internal-delay-ps arch/arm64/boot/dts/amlogic/
> 
>> +# A property for a clock the PCB already delays is not in this table.
> Can you please explain this sentence (I'm not a native English speaker)?
> How I interpret the sentence: The PCB may add delays but those are
> implicit and not part of the {rx,tx}-internal-delay-ps properties. If
> the delays added by the PCB don't cover the full 2ns requirement then
> either MAC or PHY need to add the remainder, see fine-tuning below.
> 
>> +# It is either the fine tuning described next, or a mistake the MAC
>> +# should report as a fatal error.
> How can I differentiate between "fine tuning" and "mistake"?
> 
> 
> Best regards,
> Martin
The patch is wrong. It assumes a present property moves the 2ns from
the PHY to the MAC, and Andrew's reply on patch 4 says it does not.
I am dropping it in v4.

thanks
Lucas

