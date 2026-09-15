Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287444C50B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499973; cv=pass; b=PrU3+zap4BIK9r93uMMsq3+YwptZHlmrdqdaDY/RQ3hjOqYN2HYJHuEoV5E7g8hK28CoRsCHY8a7w07xaohjhcSe6x4RPIzDoDQK/m6ue+IC7jxK783DgyCXIw6lUv22Q21pyQfEVoF0ULKQgbFexjeR/KxYlwtOH/CT/jGWDHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499973; c=relaxed/simple;
	bh=BlMkm+9woMj+xKyPkIuWnItKgorsfZcu+PZ6qC0KBys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtWcPeuWxHOFH6VMvHDnQLDiE5mYtrTmn20YvsduG0LoLCLg5fX132g7o5R3H4dSx588o77mtVFTFx66t5vc+DAq03S1UmfcPRytyEbrAjldpj1YVULGl1c1nmkcyLRK2VDshvWHwSm6W56Hw+Die2bC57hpm9k/4xZmrAOclpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2Sd4CVh; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2Sd4CVh"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so26155ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499970; cv=none;
        d=google.com; s=arc-20260327;
        b=aKUaHcPUtye//vaFusd4CF++ud6m5+OtLaXsFa7HqfpFQLFTt6Lb/yYuf2iddpUNLO
         SR+aDE5dsjWjGOYHFwV9d39jXr6FAUTIz9xzG7WrofeM1D7mEkIc4SO23q56duCZY59k
         4h9y2ACYxaPRyEhYQU3Me5/jizJGoTSgxXSVsEaO3Xaxoo/tuGZTbV71ohrVNk6bXANh
         JzNtnEijXl6pL6tkgP/0VDIvnfMGyNwTo/kKi6s82TaB/BuupvseWcOw0CNE9RMfbPkE
         0DtkfAVtejzYVkLeIIroXIXtcsylHpdqf5/zwNQiCZSZ+YIN0JIYVlMVbFTZbnqMyLxB
         pf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f7MJMTvCGCwhFtwY5bpQwMB51rPUKMNf/iflex/yXpY=;
        fh=QMcn74vbFUtFNoON/a9BE00rkaXIVBh7VX5nkEOPQz0=;
        b=C8cc+VwhvA4P0uveaIQpOfkELE5QXq/3crAEqnILPH/dfwklWFRLTrY4srokhN3DKl
         2jOEC68n8hxkkPXChp0E/hbTkG4cFPTci6gYQN3h69lxaMA69etSBD6QLRS66usiDzuc
         sUirG9ZJtDALzoxVqPnJ2ZJDVACqKWsUHBAtpEcUehNdPaZJuqPitnFMQf/UCI57l52m
         cK144iiNiRVuLt+ImAO+mnSa2KOLrEyjrD5t2P48ThFzwy2fHDa3f3Ryas/6X7myabZ0
         z9kBwxFGnFAw1uqmAebzMkndCMYB8Xo5C3k4mZOUAJFDK0RaWe4oh2JC1E2q9fklpQaw
         clRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789499970; x=1790104770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7MJMTvCGCwhFtwY5bpQwMB51rPUKMNf/iflex/yXpY=;
        b=X2Sd4CVhwBK8TebLcxBtwoeqNzNL+icdUMZqZdtjtkpf8Fan6/+yBiMWTvzUv+PxiJ
         fbtkZKEh4ZhIoMjffVDuuubF2pNqrAIkdrp4m768SHzET1U3pXYCShabknMLuD6yYU8/
         R+FzJFED5oolt6cgRr0PGPaD6EJsyXDERM44B29kC5pagc8OmeLmit5lEaOhW2G6GdAg
         TKwRS6OgMWsic5vw/zVfbm0euGIYp4THdoFpQjFFcu7FUyjNV/C62/emAecPrjiyg5Ta
         2gb56dQJgdmS0I9jIuQ9nJytpXJEajxgsJj8VbdEUSRUDSRBedHAhNZFFAeqyHR0h9R1
         giqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499970; x=1790104770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7MJMTvCGCwhFtwY5bpQwMB51rPUKMNf/iflex/yXpY=;
        b=PyR7UmByYzQVhMhrM+7UKzNAei4n2zo1tCE/u9IYXa0UMkkIQRcOt+3sN4AKdsFqPO
         H8b+vK2sxFJlZYXaooARa/+Z9H7g3WVxrCCvdPZKf1clI/b3h1pPbO98XUH72mbST4fG
         YQ3n5MYcVTM6eR0otqV8SNywmCqFlYTsWOp6XDEU6y0ddl0HLpucFvDpc9sKww1eKQ8Z
         tQuoSWxxJgcNMrAjBRAymN9MtltqtjA30lnUwWAdv1wykD8YouMU/nIMSZN0QvJUqQRR
         ISL33+YZEvDth83CUYRXc3MiVSmPmEydZXrSlxMzTChInIkXhUuHSY74cxDKYtZHe6Sy
         6V1Q==
X-Gm-Message-State: AFuF++krExsAD259UIMHuNoezP5aEDoWeH2OBP/0CWf1aScOCU3XjIJL
	Ana5+yPRRCq/qWg03H+XiQk4xq+OZex3YcqXs42vO0sMIfg6GRyr10bvzjdopZLwR2fnLY/Rb0B
	YWRCDCUcuRRte9qTD5wM7pYgmE9S5DIImT+1RjFCM
X-Gm-Gg: AYBFou0dvc/R9PpUTUcMZJ5N++7rK0OHKztfa6Z5yvAZu+dPgA+0GqoBM2S+Vxbwz5L
	M0y43DzyzWfTxq1l4mhCOY669IMI02FLHEZlwfcFUOZFpWbObAHih5WMsiAMaVc8AwcEtfppxka
	H3rRhssDgXR4fJsOJu6b+9QVtye95q5LMRUOHtP7zmXFiI60WMQ1kzHNBZqizrqSbyJE9orUexL
	g0oSmwHF93/QMK1zpbz4usG669YjUv9+qTmVLvpx/o2Er/z6QH4jhhqXsl+gm8bsiR+iguGLBVF
	hN7zskdhPgGHLQJv7eOdUqrD9DtLBbPNATXKmuaY+2cXvmQ+jMz6j4DQjOt26NPAvKA7UnIrNuV
	CMKGKJUjb0P7h3heUn2cEzUrhwtO5/+ilUEobYyaNTWjcd0zvh30hAu1g
X-Received: by 2002:a17:902:d54e:b0:2dd:56dc:b75a with SMTP id
 d9443c01a7336-2dd89c5a75cmr1182795ad.10.1789499969867; Tue, 15 Sep 2026
 12:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915093714.18815-1-mengyuanlou@net-swift.com>
In-Reply-To: <20260915093714.18815-1-mengyuanlou@net-swift.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 15 Sep 2026 12:19:18 -0700
X-Gm-Features: AcwNN1U2WVbNBYKMP-m-Y3lrNZliPOX5NHUH_PsWQDlB6Y2xK8xzo5DYNP9rHws
Message-ID: <CAEAWyHfFYryMvtb+9XRY-hjjDpxiZUjfKX9ShK4My7Wtz-Dj2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: libwx: Add ethtool -L support for VF drivers
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com, 
	przemyslaw.kitszel@intel.com, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:18=E2=80=AFAM Mengyuan Lou <mengyuanlou@net-swift=
.com> wrote:
>
> Implement get_channels and set_channels ethtool operations for Wangxun
> VF net_device instances in libwx.
>
> This allows users to query and dynamically reconfigure the number of RX/T=
X
> channels on VF interfaces via `ethtool -l/ -L`.
>
> Specifically:
> - Add wx_get_channels_vf() and wx_set_channels_vf() to report and update
>   channel limits and combined queue counts.
> - Re-evaluate RSS limits in txgbevf_set_num_queues() based on user settin=
gs
>   stored in wx->ring_feature[RING_F_RSS].limit.
> - Adjust VF MRQC RSS hash mask logic in wx_setup_vfmrqc_vf() to correctly
>   match queue configuration thresholds.
>
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 64 +++++++++++++++++++
>  .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  2 +-
>  .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  3 +
>  3 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/ne=
t/ethernet/wangxun/libwx/wx_ethtool.c
> index 940d2e59876c..d24370790941 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -564,6 +564,68 @@ int wx_set_channels(struct net_device *dev,
>  }
>  EXPORT_SYMBOL(wx_set_channels);
>
> +static void wx_get_channels_vf(struct net_device *dev,
> +                              struct ethtool_channels *ch)
> +{
> +       struct wx *wx =3D netdev_priv(dev);
> +
> +       /* report maximum channels */
> +       ch->max_combined =3D wx->mac.max_rx_queues;
> +
> +       ch->max_other =3D 1;
> +       ch->other_count =3D 1;
> +
> +       /* record current channels */
> +       ch->combined_count =3D wx->num_rx_queues;
> +}
> +
> +static int wx_set_channels_vf(struct net_device *dev,
> +                             struct ethtool_channels *ch)
> +{
> +       struct wx *wx =3D netdev_priv(dev);
> +       u16 rss_limit;
> +       int ret;
> +
> +       rss_limit =3D wx->ring_feature[RING_F_RSS].limit;
> +
> +       /* verify other_count has not changed */
> +       if (ch->other_count !=3D 1)
> +               return -EINVAL;
> +
> +       /* verify the number of channels does not exceed hardware limits =
*/
> +       if (ch->combined_count > wx->mac.max_rx_queues)
> +               return -EINVAL;
> +
> +       /* if device is resetting, do nothing */
> +       if (test_bit(WX_STATE_RESETTING, wx->state))
> +               return -EBUSY;
> +
> +       wx->ring_feature[RING_F_RSS].limit =3D ch->combined_count;
> +
> +       if (netif_running(dev))
> +               wxvf_close(dev);

The precedent has been for some time now that drivers are required to
pre-allocate resources for the new queue counts before tearing down
the existing ones. So that the driver doesn't knock itself out if
something fails when attempting to apply the new configuration.

Look at the nfp_net_ring_config() or gve_adjust_config() for examples:
both try to allocate memory for the new config first.

> +
> +       wx_clear_interrupt_scheme(wx);
> +
> +       ret =3D wx_init_interrupt_scheme(wx);
> +       if (ret)
> +               goto err_out;
> +
> +       if (netif_running(dev)) {
> +               ret =3D wxvf_open(dev);
> +               if (ret)
> +                       goto err_close;
> +       }
> +
> +       return 0;
> +
> +err_close:
> +       wx_clear_interrupt_scheme(wx);
> +err_out:
> +       wx->ring_feature[RING_F_RSS].limit =3D rss_limit;
> +       return ret;
> +}
> +
>  u32 wx_rss_indir_size(struct net_device *netdev)
>  {
>         struct wx *wx =3D netdev_priv(netdev);
> @@ -852,6 +914,8 @@ static const struct ethtool_ops wx_ethtool_ops_vf =3D=
 {
>         .set_coalesce           =3D wx_set_coalesce,
>         .get_ts_info            =3D ethtool_op_get_ts_info,
>         .get_link_ksettings     =3D wx_get_link_ksettings_vf,
> +       .get_channels           =3D wx_get_channels_vf,
> +       .set_channels           =3D wx_set_channels_vf,
>  };
>
>  void wx_set_ethtool_ops_vf(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net=
/ethernet/wangxun/libwx/wx_vf_lib.c
> index 7325b475ee10..6fec3ab5e4e4 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
> @@ -237,7 +237,7 @@ void wx_setup_vfmrqc_vf(struct wx *wx)
>
>         vfmrqc |=3D WX_VXMRQC_RSS_EN;
>
> -       if (wx->num_rx_queues > 3)
> +       if (wx->num_rx_queues >=3D 3)
>                 vfmrqc |=3D WX_VXMRQC_RSS_HASH(2);
>         else if (wx->num_rx_queues > 1)
>                 vfmrqc |=3D WX_VXMRQC_RSS_HASH(1);
> diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/driver=
s/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> index 8b16b900820a..6e8659082051 100644
> --- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
> @@ -72,6 +72,9 @@ static void txgbevf_set_num_queues(struct wx *wx)
>                 queue =3D min_t(u16, wx->mac.max_rx_queues, wx->mac.max_t=
x_queues);
>                 rss =3D min_t(u16, queue, rss);
>
> +               if (wx->ring_feature[RING_F_RSS].limit)
> +                       rss =3D min_t(u16, rss, wx->ring_feature[RING_F_R=
SS].limit);
> +
>                 if (wx->vfinfo->vf_api >=3D wx_mbox_api_13) {
>                         wx->num_rx_queues =3D rss;
>                         wx->num_tx_queues =3D rss;
> --
> 2.30.1
>
>
>
