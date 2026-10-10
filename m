Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EE3822B4
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791671846; cv=pass; b=rY/7naH09ULilLRHjHGilE3vcwypSrSZKI/EdH/AwMxYOHMQzmlZf03yNM/8RjgxbErM6b4SmDBnHN81nthRpAELgy4nldOZvIpYz5nb53Z9P/TjcRhekVAXmVzW+SPs/qFgdtDAjxKzIzie7zBVROyULALqUg7OyQC2qR/zhDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791671846; c=relaxed/simple;
	bh=Edn/b7yHTs0QFZu4M/RBjveqNZ3qiAFmLJfm7m0vLn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhZzHTGU3i2RFH34s0OnOiREob40eH4F6QJ+nyNcinvDWxbuubdEc1Y4shdyhMl45Oonkgqe496iaE6OEm8SEjtaC5L6seTlLLpNMwDkqBPfXnDtENuh+k7QlnbR1MxUjanYHL5iITq+Qw2hinANHKePPI9qW03o7DBgALsj7S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mQPVP+Bp; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mQPVP+Bp"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-677af43eed4so625715d50.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791671844; cv=none;
        d=google.com; s=arc-20260327;
        b=YAl7oSweUJEFH3GiRhNEfNURqcpxMgFSoUGHxnlyPsXn2Fx8c91fMp9i/97v0m32M1
         l8177KrYzzrtivcPL/jqHkNL7GKcEe2Pc5YzGL/zO18oLwP5YWPyuG8GuQHMsnhpFycB
         Qc0Zzy3RhAndzUG5lQ7ymPCas1RWAtSaF8DkfPEeWP+l5AoyffVuEBorPohwJGzfX2/x
         U16paBHZynq2ORcnjBTqzpDy0m63mH6p7ttZgx6n8KMXkK8wQlRc2PADdhax5r73OHtN
         uZngVHfhNeatm0yR72eSSzdLLIuAO4WW+ZV/za2VCfsznz7bnQPAc/QEeX+bt/sfvYvz
         XzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aaF1dXMmLkK5pzKGy77HkgIVspRqizj4NjSYijx6kNE=;
        fh=HM+n1E8KnLlXL4G+w5x2EMIjbANGz9eGgsjuHOn+qiI=;
        b=mOHsA3jQcPX/r6prPiIuV3A2APtzFGWVCsQjv2duPZIhRzJ2nuyDW2OtORmCcKZt82
         6ZwSwE7wFi9hwDGO7x6uW6sgBApVaem35pdpDqkSDoeJlkVIMNlbIUSliBkSqj5AMq/U
         ofzsBMzebxUdqnzp67/3A0/xExs75wIoMZP9wNuIiQkTSHffTBI0DL6pxcm+7AIY2mZX
         ah/J1vNKQJXp5DS61K14SxkHlwVQR4p83rxgApcuLZBCKOrDgvxdSHawSrb6z2AbYq7/
         CR3yc7O7v3wFtK51v6fxS0B5IIYWbd66vIimJpCIg30Ay+51992TcIAabGqivyrkdaMW
         UnDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791671844; x=1792276644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aaF1dXMmLkK5pzKGy77HkgIVspRqizj4NjSYijx6kNE=;
        b=mQPVP+BprV4H0rZWB2FZDlYu6LTcaA8A7wu+OF1tcZUWLQVjN0+Gcs3eErEXTr/81e
         WPFvXfPMTIyI9I6yuKktuw4VkaFpZ7hZGaokdQ+XyUzGIAZoBx7/bwz/TTTTAhlFeBIs
         C3u+eFc6+Ljc6OkYA3XiJdkQnIfoxLlOZ4UFlolJwdi3T9LNVm7vcY4oebiNAvw9ctaD
         0DijPhUbOH5X2+5i/aS5MAOKGxRtTxlar6x2+16R58Vhoy8ND/cMl2//n5hybH1qZmGI
         ghfsm23tCFRGs7aucKptuQsxXycdlvWO/mtQIg6OqwWGyUY7m/hQS3tUKrnLooxQd032
         CSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791671844; x=1792276644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aaF1dXMmLkK5pzKGy77HkgIVspRqizj4NjSYijx6kNE=;
        b=pVWnh+TmNoDxp8gXbcATcCpGMiaot0aXmyAnABS+jYIOvpjqrIke/h1pOz4I4HbgOP
         lb/b9vmn/TCA60Xgfg0F72rzSiQqUC1H0rCR2ifZxE7NG1tbOrDkX39We6RoM0jHxpi7
         u1MfFGM+lNUDOv9c3qDqtP9PJF4NCZvSq2Hf680WXolDfF/GM9jWuOVVURf81IMx9QBK
         jpSydF8dTK8yuZtGucIH+F/1NnEmiuzfx/6F+rfl+r52qY5PmbbfaEe3wInjgInp7XTL
         QAo6j0MG/aAowZF0AOHAE9n7EtJoml/rFkqBJGXQQdYoVhq85AyFTmWVDiuNbmh3ye6D
         wuQA==
X-Forwarded-Encrypted: i=1; AKwUvBzEZ7won9f5A5OUM1U4BW78GZr9wtcBL86vHOHoV9TWY9ibz13B8FbZnIbkiiV7jjPjorv+mAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKgE5xWfZGF86J3ScDXHOtKHgajGHBE1RMq78DZZTuHWPDb2C9
	QcbvxCgkmnIeeZaNscA56zk4AZh2VW1q/RDL6zJC+DXQOI+YBMs/YYV39QWUpNLJXX6kg00l9RY
	UqFQ0Xtkb5LDP0MPncC7Bm0IZ1/4tu2M=
X-Gm-Gg: AYBFou3rMGGhGJ3ParxSx8jbfJMIQO2vqmBZ1mB6Cjfwf5qCLfXUUK+8+uGIzPDPCKV
	hLNRiu9gDF3N8YpD8dl/KhobKTlgVuOZlvJY++pe+U0NJpcCocwkRmj1TfID0n7EHkthT43HRk+
	C7a07JI8bn4ZY1umrmx5rwh+r7sdXnlsCrCQLLlZK5dorTrfHDzMjI1DTO4Xhf2Ss9NVdqKQPHh
	MYBq5FYej7VaCvP7DOQUnI1KblQhYZaOHGo+SEKFIyQBlVOJ5KYY4B6cdL9TCsAewM1gqmslM5d
	+kZPNmbOs09BWz2F7GDYRA12YnxAX8oZEpFVqPAi50Vo6O2GbYCbhHOG8V3RfTb3vj1FsynfbRP
	nQ8EKyVfz1MhQ
X-Received: by 2002:a05:690e:4813:b0:677:c63c:ed3f with SMTP id
 956f58d0204a3-67936a45e25mr1411453d50.69.1791671843883; Sat, 10 Oct 2026
 15:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-9-tanure@linux.com>
In-Reply-To: <20261010105900.247342-9-tanure@linux.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 11 Oct 2026 00:37:13 +0200
X-Gm-Features: AclHuK83tYlY1Yg4pW9pjFmYK85k4ljD0olzP_yaTJsbdkiweyuLFexiO6_OaD4
Message-ID: <CAFBinCB8203vL6YK3+V2zDhz=qqeAwJoufPM60cD0Vz3s-OS6g@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] dt-bindings: net: ethernet-controller: tabulate
 who adds the RGMII delays
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Hi Lucas,

On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> wr=
ote:
[...]
> +#   phy-mode    tx-internal-delay-ps  rx-internal-delay-ps  TX delay    =
RX delay
> +#   rgmii       -                     -                     PCB trace   =
PCB trace
> +#   rgmii-id    -                     -                     PHY         =
PHY
> +#   rgmii-id    present               -                     MAC         =
PHY
> +#   rgmii-id    -                     present               PHY         =
MAC
> +#   rgmii-id    present               present               MAC         =
MAC
> +#   rgmii-txid  -                     -                     PHY         =
PCB trace
> +#   rgmii-txid  present               -                     MAC         =
PCB trace
> +#   rgmii-rxid  -                     -                     PCB trace   =
PHY
> +#   rgmii-rxid  -                     present               PCB trace   =
MAC
We have some boards where the PCB traces result in part (1200ps) of
the delay needed for RGMII (2000ps).
The remainder (800ps) has to be added by either PHY or MAC: the
(RTL8211F) PHY can only generate 0 or 2000ps delay so the MAC has to
take over.
For the three boards I have in mind, please see $ git grep
rx-internal-delay-ps arch/arm64/boot/dts/amlogic/

> +# A property for a clock the PCB already delays is not in this table.
Can you please explain this sentence (I'm not a native English speaker)?
How I interpret the sentence: The PCB may add delays but those are
implicit and not part of the {rx,tx}-internal-delay-ps properties. If
the delays added by the PCB don't cover the full 2ns requirement then
either MAC or PHY need to add the remainder, see fine-tuning below.

> +# It is either the fine tuning described next, or a mistake the MAC
> +# should report as a fatal error.
How can I differentiate between "fine tuning" and "mistake"?


Best regards,
Martin
