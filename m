Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691376;
	b=ZLM3e/Nz3jN5qumWVY9pyYP/EARAMESzwEeSXnYRmFIKgqBxnz/wNxc5wf2mrU9FaNxN
	 frVXtmdoNksV4uyjjfmc3Xdc6UdImjTpMHoUSN+AkYBVsVUZuqyLdntBB8iPf+TQgWclW
	 Ngn6LlseHirqfFPkV3qW+FCm/rn+47i13AbWfbndgc8Q3jr5XFlfGynBo+n5avOuBXT3a
	 CKq4JfSat4aSHb4JYB9CLVHlZ5/fuwepO4HLNxeRG91BuXH5WMF3n71jA3MMp2FgsHUPK
	 nCK5RK14Q3UHtpLJBJLT8swYG3FEct9UPeGdM9CHbjsmt0W88LmDFqU2Re3dyZwU3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691376;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HmShLIi0Try9xlFwdP7Bt6IdYlCRVmbmMWtY33HkzA4=;
	b=WY6ktBljujRguy/qc8YWqsAQDyajxAUKfJf8s20o2l//UO+ae+2FHXWiCHSzYY6x9M0/
	 Rq/XDniml2FAWQ/Sd7Yvd+lyAuZxS9cD1FNkJ0QjE/5tKvJ6YXF4mF0cG7syoSTZ077ct
	 4jf4gvwDFvEYYxRUPvYHMGk6xgVtHLSYoveWZepgAUM+7wxoRhlvImNRjt1RuCdFm7GEn
	 pKvUsTPsfDJg2yg7SUmtCvrjY0biqMnyRerrQirawztWp8A2jf5v2d1dnd+ETzrdk2bAz
	 vcOvsk8NM6XzTT0oeIg3C4rCVHy4OMpvqMT+BHo/wfrCTvDg/WSGuK93D4p12o2O6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6C606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FF6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so516375e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691374; x=1793296174;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmShLIi0Try9xlFwdP7Bt6IdYlCRVmbmMWtY33HkzA4=;
        b=N/b9eAmj6wiy3WSlBU8UNHT9dJjTXsK/vULgjBeXXOMGjvjz8Q8VETHJZ2G29l+aOO
         rHQUv4nZYGAxDip7Cafk0ipgLlUftObvnBT54zotGJJkK7O6ran/5kqJEQgq4EKDgLEF
         llXSjBzusmzWzDuJT/MXwSXO3YtP93TmGfH61IhddxMP7mvvW1yasfog9JHbqysRinzi
         QDlip5jllOXUdG/Ovpr+tzWUXMcHIyF9vkY8oBcK+3FjNDDNluelLvULW9c2Hq/G43k6
         8guCcpjPjjQPC3g3dIr+Gk/NG0dnYG36qQxkfgLu9htv+BtUNYuTGrvyuvzih9lrnkSD
         5Lhw==
X-Forwarded-Encrypted: i=1; AKwUvByOJNLB9v5siKxBvZFbrz+jNF2vhOeTFdtrGvK94uoC9BcT6SM+A0GniQrA0BRDiD3SiPMQFMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRpyKjoEwAEmKJPXmMSAEiOa5+W05K92APHSgGo7v3T70mdOca
	yc5YfluFbmPuZn6uXZ08IitTicKAFKT2MckD5mSbNn8twFTJBj6Mb5aL
X-Gm-Gg: AYBFou2mHdt6JfqvSQNoMlfSwL9Pes8PIMfpcLL0Tr1RLGuwBXAEqcNVFPXBrPNPUyo
	+py6H/yp8jQ+SDobJnMcwGhlyJX+GbJE48U0Ubsfz1ypHZYXeu8bJ3tWTDOv8SatUai1M8m7wTv
	QSg+evnHdZ3lqmhMw/IgDyRQTiql9yWwhxdMd82Qce0h3L3Yq+6pR0keVJ822fts+KI07fntS5L
	msuebFlmEutAc76LXErSmwmb1AP5HJXiaV+C5ae4pugS1js9dEnf1bMc1nweA/2syLFQRHYKEgI
	iwxb3XEZ9FwN//cE1gg92a6WZNj+9SWJ8nH+2hQ2vlENiuBfXQiZ75FDbG00NLWPmMXZsNQ3Vah
	jxRKlFId9Xw3vMGgyGyTdnaaUl/Dd8NpEwB2ughZNGVRcZp53uPzhatPhBGunz32vumg2zSMo2g
	EZvpOjUGwi9OxcMNt0tpxGX1KXYMl2sQdAnW5qNqUsT9JhZCFTfswNu1PeMWf6urQkL8Y2yT6+l
	uK9M31XKsFgJJmIRXYwjCpdPvcjFa27cm9dlz0RxPh3w6OwnKzqFBVLuT4ty4KAt/SXKh7sNlpG
	LJ4gNvih4w==
X-Received: by 2002:a05:600c:4684:b0:4a1:d36f:1ba0 with SMTP id 5b1f17b1804b1-4a1fdd74b6cmr122177475e9.35.1792691373949;
        Thu, 22 Oct 2026 10:49:33 -0700 (PDT)
Received: from [192.168.1.135] ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21047b2absm13451355e9.13.2026.10.22.10.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:49:33 -0700 (PDT)
Message-ID: <a23b3a53-9cdf-4e32-8ca8-a80d927d65e2@linux.com>
Date: Thu, 22 Oct 2026 18:49:32 +0100
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
To: Conor Dooley <conor@kernel.org>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261010105900.247342-1-tanure@linux.com>
 <20261010105900.247342-9-tanure@linux.com>
 <20261012-suds-karaoke-efc4acf056af@spud>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <20261012-suds-karaoke-efc4acf056af@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2026 20:18, Conor Dooley wrote:
> On Sat, Oct 10, 2026 at 11:59:00AM +0100, Lucas Tanure wrote:
>> The informative section explains in prose how phy-mode, the delay
>> properties in the MAC node and the mode handed to the PHY fit together,
>> and says itself that developers often get this wrong. A reader has to
>> work through several paragraphs before answering the one question they
>> usually have: for this phy-mode and these properties, which part adds
>> which delay.
>>
>> Add a table that answers it at a glance, with one row for every
>> combination the properties allow.
>>
>> Assisted-by: LLM
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> 
> If the net guys think this is valuable,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
Thanks, but I will drop this patch as is wrong.> (although for something 
like this, us acking probably ain't needed,
> ehh?)
> 
>> ---
>>   .../bindings/net/ethernet-controller.yaml      | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> index 1bafd687dcb1..bba27a9feb61 100644
>> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
>> @@ -339,6 +339,24 @@ additionalProperties: true
>>   # has added. Failure to remove the delay will result in a
>>   # non-functioning link.
>>   #
>> +# Put together, with the two properties in the MAC node, this is who
>> +# adds each delay:
>> +#
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
>> +#
>> +# A property for a clock the PCB already delays is not in this table.
>> +# It is either the fine tuning described next, or a mistake the MAC
>> +# should report as a fatal error.
>> +#
>>   # Sometimes there is a need to fine tune the delays. Often the MAC or
>>   # PHY can perform this fine tuning. In the MAC node, the Device Tree
>>   # properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
>> -- 
>> 2.56.0
>>

